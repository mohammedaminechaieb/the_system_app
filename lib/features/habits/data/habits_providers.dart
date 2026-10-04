import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';
import '../../quicklog/data/quicklog_providers.dart';

class HabitWithStatus {
  final Habit habit;
  final bool done;
  final int streakDays;
  const HabitWithStatus({required this.habit, required this.done, required this.streakDays});
}

/// All active (non-archived) habits, ordered, joined with today's completion.
/// Watches both `habits` and `habit_logs`, so ticking a habit (which only
/// writes a log row) updates the list immediately.
final todayHabitsProvider = StreamProvider<List<HabitWithStatus>>((ref) {
  return watchTodayHabits(ref.watch(databaseProvider), ref.watch(todayKeyProvider));
});

Stream<List<HabitWithStatus>> watchTodayHabits(AppDatabase db, String todayKey) {
  return watchTables(db, {db.habits, db.habitLogs}, () async {
    final habits = await (db.select(db.habits)
          ..where((t) => t.archived.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
    final doneLogs = await (db.select(db.habitLogs)..where((t) => t.done.equals(true))).get();

    final doneDatesByHabit = <String, Set<String>>{};
    for (final l in doneLogs) {
      doneDatesByHabit.putIfAbsent(l.habitId, () => {}).add(l.date);
    }
    return [
      for (final h in habits)
        HabitWithStatus(
          habit: h,
          done: doneDatesByHabit[h.id]?.contains(todayKey) ?? false,
          streakDays: computeHabitStreak(doneDatesByHabit[h.id] ?? const {}, DateTime.parse(todayKey)),
        ),
    ];
  });
}

/// Consecutive days ending today (or yesterday, if today isn't logged yet —
/// a not-yet-logged today shouldn't zero the streak) found in [doneDates].
int computeHabitStreak(Set<String> doneDates, DateTime today) {
  if (doneDates.isEmpty) return 0;
  var cursor = DateTime(today.year, today.month, today.day);
  if (!doneDates.contains(dateKeyOf(cursor))) {
    cursor = cursor.subtract(const Duration(days: 1));
  }
  var streak = 0;
  while (doneDates.contains(dateKeyOf(cursor))) {
    streak++;
    // Constructing from parts (rather than subtracting 24h) stays correct
    // across daylight-saving changes.
    cursor = DateTime(cursor.year, cursor.month, cursor.day - 1);
  }
  return streak;
}

/// Toggles a habit's completion for today, awards points, and re-checks
/// whether the daily gate should now be considered passed.
class HabitActions {
  final AppDatabase db;
  final StreakEngine streakEngine;
  HabitActions(this.db, this.streakEngine);

  Future<void> toggle(String habitId, String dateKey) => db.transaction(() async {
        final existing = await (db.select(db.habitLogs)
              ..where((t) => t.habitId.equals(habitId) & t.date.equals(dateKey)))
            .getSingleOrNull();

        final newDone = !(existing?.done ?? false);

        await db.into(db.habitLogs).insertOnConflictUpdate(
              HabitLogsCompanion(
                habitId: Value(habitId),
                date: Value(dateKey),
                done: Value(newDone),
                completedAt: Value(newDone ? DateTime.now() : null),
                // A tick resolves any earlier 'missed_opportunity' marker.
                outcome: newDone ? const Value(null) : const Value.absent(),
              ),
            );

        final habit = await (db.select(db.habits)..where((t) => t.id.equals(habitId))).getSingleOrNull();
        final tier = habit?.tier ?? 1;
        final quickLogs = QuickLogActions(db);
        if (newDone) {
          await streakEngine.awardHabitPoint(tier: tier);
          await quickLogs.add(type: QuickLogType.habit, subtype: habitId, value: 1, unit: 'done', dateKey: dateKey);
        } else {
          // Undo everything the tick granted, so tick/untick can't farm
          // points or screen time.
          await streakEngine.revokeHabitPoint(tier: tier);
          await quickLogs.deleteHabitTick(habitId, dateKey);
        }

        await reevaluateGate(dateKey);
      });

  /// The gate passes once every core habit is done for the day.
  Future<void> reevaluateGate(String dateKey) async {
    final coreHabits = await (db.select(db.habits)
          ..where((t) => t.isCore.equals(true) & t.archived.equals(false)))
        .get();
    final logs = await (db.select(db.habitLogs)..where((t) => t.date.equals(dateKey))).get();
    final doneIds = logs.where((l) => l.done).map((l) => l.habitId).toSet();

    final allCoreDone = coreHabits.every((h) => doneIds.contains(h.id));

    await db.into(db.dailyState).insertOnConflictUpdate(
          DailyStateCompanion(
            date: Value(dateKey),
            gatePassed: Value(allCoreDone),
            gatePassedAt: allCoreDone ? Value(DateTime.now()) : const Value(null),
          ),
        );

    // With no core habits there's nothing to complete — don't hand out a
    // free streak day just because the set is empty.
    if (allCoreDone && coreHabits.isNotEmpty) {
      await streakEngine.markDayComplete(DateTime.parse(dateKey), allCoreDone: true);
    }
  }
}

final habitActionsProvider = Provider<HabitActions>((ref) {
  final db = ref.watch(databaseProvider);
  final engine = ref.watch(streakEngineProvider);
  return HabitActions(db, engine);
});

/// Create/edit management for habits themselves — separate from
/// [HabitActions] (which only toggles a day's completion) since these
/// touch the habit definition, not a day's log.
class HabitManagement {
  final AppDatabase db;
  HabitManagement(this.db);

  Future<void> create({required String label, required String icon, int tier = 1, bool isCore = false}) async {
    final existing = await db.select(db.habits).get();
    final existingIds = existing.map((h) => h.id).toSet();
    // Slug from the label, de-duplicated — never overwrite an existing habit
    // (and its history) just because a new one has a similar name.
    var base = label.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_').replaceAll(RegExp(r'^_+|_+$'), '');
    if (base.isEmpty) base = 'habit';
    var id = base;
    for (var n = 2; existingIds.contains(id); n++) {
      id = '${base}_$n';
    }
    await db.into(db.habits).insert(
          HabitsCompanion(
            id: Value(id),
            label: Value(label),
            icon: Value(icon),
            tier: Value(tier),
            isCore: Value(isCore),
            sortOrder: Value(existing.length),
          ),
        );
  }

  Future<void> setTier(String habitId, int tier) => (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(HabitsCompanion(tier: Value(tier)));

  Future<void> setCore(String habitId, bool isCore) => (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(HabitsCompanion(isCore: Value(isCore)));

  Future<void> setArchived(String habitId, bool archived) => (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(HabitsCompanion(archived: Value(archived)));

  /// Setting a scheduled time is separate from actually creating today's
  /// calendar block (see CalendarService.scheduleForToday) — this just
  /// records the habit's daily target time; the block itself is (re)made
  /// each day the person opts in from the habit tile.
  Future<void> setScheduledTime(String habitId, String? hhmm) =>
      (db.update(db.habits)..where((t) => t.id.equals(habitId))).write(HabitsCompanion(scheduledTime: Value(hhmm)));

  /// All habits including archived — used by the habit management screen,
  /// which unlike the gate/today lists needs to show everything.
  Stream<List<Habit>> watchAll() => (db.select(db.habits)..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).watch();
}

final habitManagementProvider = Provider<HabitManagement>((ref) {
  final db = ref.watch(databaseProvider);
  return HabitManagement(db);
});

/// Whether today's gate has been passed — drives the soft-lock screen.
final gateStatusProvider = StreamProvider<bool>((ref) {
  final db = ref.watch(databaseProvider);
  final todayKey = ref.watch(todayKeyProvider);
  return (db.select(db.dailyState)..where((t) => t.date.equals(todayKey)))
      .watchSingleOrNull()
      .map((row) => row?.gatePassed ?? false);
});
