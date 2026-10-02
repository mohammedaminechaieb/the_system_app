import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../calendar/calendar_service.dart';
import '../database/app_database.dart';
import 'core_providers.dart';

/// Point values — tuned so consistency beats intensity (matches app philosophy).
class StreakRules {
  StreakRules._();
  static const int pointsPerCoreHabitDone = 5;
  static const int pointsFullDayBonus = 10; // all core habits done same day
  static const int penaltyPerMissedDay = -8;
  static const int streakFreezeRefillEveryDays = 14; // earn back a freeze
  // Screen-time-as-currency: 1 logged minute of activity earns this many
  // minutes of unlocked screen time on blocked apps (e.g. 10 min exercise
  // logged → 15 min unlocked at the default 1.5 ratio).
  static const double screenTimeEarnRatio = 1.5;
}

class StreakSummary {
  final int currentStreak;
  final int longestStreak;
  final int totalPoints;
  final int freezesAvailable;
  const StreakSummary({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalPoints,
    required this.freezesAvailable,
  });
}

final streakStateStreamProvider = StreamProvider<StreakSummary>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.streakState)..where((t) => t.id.equals(0))).watchSingle().map(
        (row) => StreakSummary(
          currentStreak: row.currentStreak,
          longestStreak: row.longestStreak,
          totalPoints: row.totalPoints,
          freezesAvailable: row.streakFreezesAvailable,
        ),
      );
});

/// Call this once per app-open (see [appLaunchEvaluatorProvider]) to reconcile
/// the streak against real elapsed time — applying penalties for any fully
/// missed days since the last time the app was opened, and consuming a
/// streak-freeze automatically if one is available instead of breaking the
/// streak outright (the "penalty AND streak, softened by freezes" design).
class StreakEngine {
  final AppDatabase db;
  StreakEngine(this.db);

  Future<void> reconcileOnLaunch(DateTime now) async {
    final state = await (db.select(db.streakState)..where((t) => t.id.equals(0))).getSingleOrNull();
    if (state == null) return;

    final todayKey = DateFormat('yyyy-MM-dd').format(now);
    if (state.lastCompletedDate == todayKey) return; // already reconciled today

    if (state.lastCompletedDate == null) return; // fresh install, nothing to reconcile

    final lastDate = DateFormat('yyyy-MM-dd').parse(state.lastCompletedDate!);
    final daysSince = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
        .inDays;

    if (daysSince <= 1) return; // yesterday or today — no gap to penalize

    final missedDays = daysSince - 1; // days strictly between last completion and today
    int freezesLeft = state.streakFreezesAvailable;
    int newStreak = state.currentStreak;
    int newPoints = state.totalPoints;

    int unforgivenMisses = missedDays;
    if (freezesLeft > 0) {
      final freezesUsed = freezesLeft < unforgivenMisses ? freezesLeft : unforgivenMisses;
      freezesLeft -= freezesUsed;
      unforgivenMisses -= freezesUsed;
    }

    if (unforgivenMisses > 0) {
      newStreak = 0; // streak breaks
      newPoints += StreakRules.penaltyPerMissedDay * unforgivenMisses;
      if (newPoints < 0) newPoints = 0; // never go negative — discouragement isn't the goal
    }

    await (db.update(db.streakState)..where((t) => t.id.equals(0))).write(
      StreakStateCompanion(
        currentStreak: Value(newStreak),
        totalPoints: Value(newPoints),
        streakFreezesAvailable: Value(freezesLeft),
        lastPenaltyDate: unforgivenMisses > 0 ? Value(todayKey) : const Value.absent(),
      ),
    );
  }

  /// Call after the gate (today's core habits) is completed for the day.
  Future<void> markDayComplete(DateTime now, {required bool allCoreDone}) async {
    final todayKey = DateFormat('yyyy-MM-dd').format(now);
    final state = await (db.select(db.streakState)..where((t) => t.id.equals(0))).getSingleOrNull();
    if (state == null || state.lastCompletedDate == todayKey) return;

    int newStreak = state.currentStreak;
    int newLongest = state.longestStreak;
    int newPoints = state.totalPoints;
    int newFreezes = state.streakFreezesAvailable;

    if (allCoreDone) {
      newStreak += 1;
      if (newStreak > newLongest) newLongest = newStreak;
      newPoints += StreakRules.pointsFullDayBonus;
      // Earn a streak freeze back every N days of a maintained streak.
      if (newStreak % StreakRules.streakFreezeRefillEveryDays == 0 && newFreezes < 2) {
        newFreezes += 1;
      }
    }

    await (db.update(db.streakState)..where((t) => t.id.equals(0))).write(
      StreakStateCompanion(
        currentStreak: Value(newStreak),
        longestStreak: Value(newLongest),
        totalPoints: Value(newPoints),
        streakFreezesAvailable: Value(newFreezes),
        lastCompletedDate: Value(todayKey),
      ),
    );
  }

  /// Award small points for an individual habit tick (called immediately on
  /// checkbox tap, independent of the end-of-day full reconciliation).
  /// [tier] scales the award — 1 (easy) = base points, 2 (medium) = 1.5x,
  /// 3 (hard) = 2x — so a harder habit meaningfully outweighs an easy one
  /// in the daily score rather than every checkbox being worth the same.
  Future<void> awardHabitPoint({int tier = 1}) async {
    final state = await (db.select(db.streakState)..where((t) => t.id.equals(0))).getSingleOrNull();
    if (state == null) return;
    final multiplier = switch (tier) { 2 => 1.5, 3 => 2.0, _ => 1.0 };
    final points = (StreakRules.pointsPerCoreHabitDone * multiplier).round();
    await (db.update(db.streakState)..where((t) => t.id.equals(0))).write(
      StreakStateCompanion(totalPoints: Value(state.totalPoints + points)),
    );
  }

  /// Screen-time-as-currency: extends this same engine rather than
  /// replacing it. Logged minutes of activity earn back screen time on
  /// blocked apps at [StreakRules.screenTimeEarnRatio] (10 min logged ⇒
  /// 15 min unlocked by default). Called from QuickLogActions.add for
  /// duration-bearing categories.
  Future<void> earnScreenTimeMinutes(String dateKey, double loggedMinutes) async {
    final earned = (loggedMinutes * StreakRules.screenTimeEarnRatio).round();
    if (earned <= 0) return;
    final existing = await (db.select(db.screenTimeCredits)..where((t) => t.date.equals(dateKey))).getSingleOrNull();
    await db.into(db.screenTimeCredits).insertOnConflictUpdate(
          ScreenTimeCreditsCompanion(
            date: Value(dateKey),
            earnedMinutes: Value((existing?.earnedMinutes ?? 0) + earned),
          ),
        );
  }

  Future<int> redeemScreenTimeMinutes(String dateKey, int minutes) async {
    final existing = await (db.select(db.screenTimeCredits)..where((t) => t.date.equals(dateKey))).getSingleOrNull();
    final available = (existing?.earnedMinutes ?? 0) - (existing?.usedMinutes ?? 0);
    final toRedeem = minutes.clamp(0, available > 0 ? available : 0);
    if (toRedeem <= 0) return 0;
    await db.into(db.screenTimeCredits).insertOnConflictUpdate(
          ScreenTimeCreditsCompanion(
            date: Value(dateKey),
            earnedMinutes: Value(existing?.earnedMinutes ?? 0),
            usedMinutes: Value((existing?.usedMinutes ?? 0) + toRedeem),
          ),
        );
    return toRedeem;
  }
}

final streakEngineProvider = Provider<StreakEngine>((ref) {
  final db = ref.watch(databaseProvider);
  return StreakEngine(db);
});

/// Runs once at app launch to reconcile missed days. Screens can watch this
/// to know reconciliation has completed before reading streak state.
final appLaunchEvaluatorProvider = FutureProvider<void>((ref) async {
  final engine = ref.watch(streakEngineProvider);
  await engine.reconcileOnLaunch(DateTime.now());
  // Best-effort — calendar access may be unavailable/denied; that should
  // never block the app from opening.
  try {
    await ref.watch(calendarServiceProvider).reconcileMissedOpportunities(DateTime.now());
  } catch (_) {}
});
