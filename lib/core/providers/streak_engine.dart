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
  static const int maxFreezes = 2;
  // Screen-time-as-currency: 1 logged minute of activity earns this many
  // minutes of unlocked screen time on blocked apps (e.g. 10 min exercise
  // logged → 15 min unlocked at the default 1.5 ratio).
  static const double screenTimeEarnRatio = 1.5;
  // A habit tick counts as this many "logged minutes" for screen time.
  static const double habitTickScreenMinutes = 10;

  static int habitPoints(int tier) {
    final multiplier = switch (tier) { 2 => 1.5, 3 => 2.0, _ => 1.0 };
    return (pointsPerCoreHabitDone * multiplier).round();
  }
}

/// UserPrefs key holding the last day (yyyy-MM-dd) whose miss has already
/// been charged, so reopening the app never charges the same gap twice.
const kStreakReconciledThroughKey = 'streak_reconciled_through';

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

/// Outcome of charging the days missed since the last completed (or last
/// reconciled) day. Pure data so the rules can be unit tested without a DB.
class Reconciliation {
  final int missedDays;
  final int freezesUsed;
  final int newStreak;
  final int newPoints;
  final int freezesLeft;
  const Reconciliation({required this.missedDays, required this.freezesUsed, required this.newStreak, required this.newPoints, required this.freezesLeft});

  bool get penalized => missedDays > freezesUsed;
}

DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

/// Days strictly between the later of [lastCompleted]/[reconciledThrough]
/// and [today] are misses. Each miss consumes a freeze if one is left;
/// any miss beyond that breaks the streak and costs points (never below 0).
/// Returns null when there is nothing new to charge.
Reconciliation? computeReconciliation({
  required DateTime today,
  required DateTime lastCompleted,
  DateTime? reconciledThrough,
  required int streak,
  required int points,
  required int freezes,
}) {
  var start = _day(lastCompleted);
  if (reconciledThrough != null && _day(reconciledThrough).isAfter(start)) start = _day(reconciledThrough);
  final missedDays = _day(today).difference(start).inDays - 1;
  if (missedDays <= 0) return null;

  final freezesUsed = freezes < missedDays ? freezes : missedDays;
  final unforgiven = missedDays - freezesUsed;
  var newStreak = streak;
  var newPoints = points;
  if (unforgiven > 0) {
    newStreak = 0;
    newPoints += StreakRules.penaltyPerMissedDay * unforgiven;
    if (newPoints < 0) newPoints = 0; // never go negative — discouragement isn't the goal
  }
  return Reconciliation(missedDays: missedDays, freezesUsed: freezesUsed, newStreak: newStreak, newPoints: newPoints, freezesLeft: freezes - freezesUsed);
}

/// Call this on app open and whenever the date rolls over (see
/// [appLaunchEvaluatorProvider]) to reconcile the streak against real
/// elapsed time — applying penalties for fully missed days and consuming a
/// streak-freeze automatically if one is available instead of breaking the
/// streak outright (the "penalty AND streak, softened by freezes" design).
class StreakEngine {
  final AppDatabase db;
  StreakEngine(this.db);

  static final _fmt = DateFormat('yyyy-MM-dd');

  Future<StreakStateData?> _state() => (db.select(db.streakState)..where((t) => t.id.equals(0))).getSingleOrNull();

  Future<void> _writeState(StreakStateCompanion c) => (db.update(db.streakState)..where((t) => t.id.equals(0))).write(c);

  Future<void> reconcileOnLaunch(DateTime now) => db.transaction(() async {
        final state = await _state();
        if (state == null || state.lastCompletedDate == null) return; // fresh install, nothing to reconcile

        final cursorRow = await (db.select(db.userPrefs)..where((t) => t.key.equals(kStreakReconciledThroughKey))).getSingleOrNull();
        final result = computeReconciliation(
          today: now,
          lastCompleted: _fmt.parse(state.lastCompletedDate!),
          reconciledThrough: cursorRow == null ? null : _fmt.tryParse(cursorRow.value),
          streak: state.currentStreak,
          points: state.totalPoints,
          freezes: state.streakFreezesAvailable,
        );

        if (result != null) {
          await _writeState(StreakStateCompanion(
            currentStreak: Value(result.newStreak),
            totalPoints: Value(result.newPoints),
            streakFreezesAvailable: Value(result.freezesLeft),
            lastPenaltyDate: result.penalized ? Value(_fmt.format(now)) : const Value.absent(),
          ));
        }
        // Everything up to yesterday is now accounted for.
        await db.into(db.userPrefs).insertOnConflictUpdate(
              UserPrefsCompanion(key: const Value(kStreakReconciledThroughKey), value: Value(_fmt.format(_day(now).subtract(const Duration(days: 1))))),
            );
      });

  /// Call after the gate (today's core habits) is completed for the day.
  Future<void> markDayComplete(DateTime now, {required bool allCoreDone}) async {
    await reconcileOnLaunch(now); // make sure any gap is charged before extending the streak
    await db.transaction(() async {
      final todayKey = _fmt.format(now);
      final state = await _state();
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
        if (newStreak % StreakRules.streakFreezeRefillEveryDays == 0 && newFreezes < StreakRules.maxFreezes) {
          newFreezes += 1;
        }
      }

      await _writeState(StreakStateCompanion(
        currentStreak: Value(newStreak),
        longestStreak: Value(newLongest),
        totalPoints: Value(newPoints),
        streakFreezesAvailable: Value(newFreezes),
        lastCompletedDate: Value(todayKey),
      ));
    });
  }

  /// Award small points for an individual habit tick (called immediately on
  /// checkbox tap, independent of the end-of-day full reconciliation).
  /// [tier] scales the award — 1 (easy) = base points, 2 (medium) = 1.5x,
  /// 3 (hard) = 2x — so a harder habit meaningfully outweighs an easy one
  /// in the daily score rather than every checkbox being worth the same.
  Future<void> awardHabitPoint({int tier = 1}) => _adjustPoints(StreakRules.habitPoints(tier));

  /// Reverses [awardHabitPoint] when a tick is undone, so ticking and
  /// unticking repeatedly can't farm points.
  Future<void> revokeHabitPoint({int tier = 1}) => _adjustPoints(-StreakRules.habitPoints(tier));

  Future<void> _adjustPoints(int delta) async {
    final state = await _state();
    if (state == null) return;
    final next = state.totalPoints + delta;
    await _writeState(StreakStateCompanion(totalPoints: Value(next < 0 ? 0 : next)));
  }

  /// Screen-time-as-currency: extends this same engine rather than
  /// replacing it. Logged minutes of activity earn back screen time on
  /// blocked apps at [StreakRules.screenTimeEarnRatio] (10 min logged ⇒
  /// 15 min unlocked by default). Called from QuickLogActions for
  /// duration-bearing categories. A negative [loggedMinutes] reverses an
  /// earlier credit (when the entry that earned it is deleted).
  Future<void> earnScreenTimeMinutes(String dateKey, double loggedMinutes) async {
    final delta = (loggedMinutes * StreakRules.screenTimeEarnRatio).round();
    if (delta == 0) return;
    final existing = await (db.select(db.screenTimeCredits)..where((t) => t.date.equals(dateKey))).getSingleOrNull();
    final earned = (existing?.earnedMinutes ?? 0) + delta;
    await db.into(db.screenTimeCredits).insertOnConflictUpdate(
          ScreenTimeCreditsCompanion(
            date: Value(dateKey),
            earnedMinutes: Value(earned < 0 ? 0 : earned),
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

/// Runs at app launch, and again whenever the date rolls over (it watches
/// [todayKeyProvider]), to reconcile missed days. Screens can watch this
/// to know reconciliation has completed before reading streak state.
final appLaunchEvaluatorProvider = FutureProvider<void>((ref) async {
  ref.watch(todayKeyProvider);
  final engine = ref.watch(streakEngineProvider);
  final now = DateTime.now();
  await engine.reconcileOnLaunch(now);
  // Best-effort — calendar access may be unavailable/denied; that should
  // never block the app from opening.
  try {
    final calendar = ref.read(calendarServiceProvider);
    await calendar.reconcileMissedOpportunities(now);
    await calendar.scheduleTodayForAllHabits();
  } catch (_) {}
});
