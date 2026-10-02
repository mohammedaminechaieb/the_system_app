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
final todayHabitsProvider = StreamProvider<List<HabitWithStatus>>((ref) {
  final db = ref.watch(databaseProvider);
  final todayKey = ref.watch(todayKeyProvider);

  final habitsQuery = (db.select(db.habits)
        ..where((t) => t.archived.equals(false))
        ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
      .watch();

  final logsQuery = (db.select(db.habitLogs)..where((t) => t.date.equals(todayKey))).watch();

  return habitsQuery.asyncMap((habits) async {
    final logs = await logsQuery.first;
    final logMap = {for (final l in logs) l.habitId: l.done};
    final result = <HabitWithStatus>[];
    for (final h in habits) {
      final streak = await _computeHabitStreak(db, h.id);
      result.add(HabitWithStatus(habit: h, done: logMap[h.id] ?? false, streakDays: streak));
    }
    return result;
  });
});

Future<int> _computeHabitStreak(AppDatabase db, String habitId) async {
  final rows = await (db.select(db.habitLogs)
        ..where((t) => t.habitId.equals(habitId) & t.done.equals(true))
        ..orderBy([(t) => OrderingTerm.desc(t.date)]))
      .get();
  if (rows.isEmpty) return 0;

  final dates = rows.map((r) => DateTime.parse(r.date)).toSet();
  int streak = 0;
  DateTime cursor = DateTime.now();
  cursor = DateTime(cursor.year, cursor.month, cursor.day);
  // Allow today to be "pending" — start counting from today if present,
  // otherwise from yesterday, so an not-yet-logged today doesn't zero the streak.
  if (!dates.contains(cursor)) {
    cursor = cursor.subtract(const Duration(days: 1));
  }
  while (dates.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}

/// Toggles a habit's completion for today, awards points, and re-checks
/// whether the daily gate should now be considered passed.
class HabitActions {
  final AppDatabase db;
  final StreakEngine streakEngine;
  HabitActions(this.db, this.streakEngine);

  Future<void> toggle(String habitId, String dateKey) async {
    final existing = await (db.select(db.habitLogs)
          ..where((t) => t.habitId.equals(habitId) & t.date.equals(dateKey)))
        .getSingleOrNull();

    final newDone = !(existing?.done ?? false);

    await db.into(db.habitLogs).insertOnConflictUpdate(
          HabitLogsCompanion(
            habitId: Value(habitId),
            date: Value(dateKey),
            done: Value(newDone),
            completedAt: newDone ? Value(DateTime.now()) : const Value.absent(),
          ),
        );

    if (newDone) {
      final habit = await (db.select(db.habits)..where((t) => t.id.equals(habitId))).getSingleOrNull();
      await streakEngine.awardHabitPoint(tier: habit?.tier ?? 1);
      await QuickLogActions(db).add(type: QuickLogType.habit, subtype: habitId, value: 1, unit: 'done', dateKey: dateKey);
    }

    await _reevaluateGate(dateKey);
  }

  /// The gate passes once every core habit is done for the day.
  Future<void> _reevaluateGate(String dateKey) async {
    final coreHabits = await (db.select(db.habits)
          ..where((t) => t.isCore.equals(true) & t.archived.equals(false)))
        .get();
    final logs = await (db.select(db.habitLogs)..where((t) => t.date.equals(dateKey))).get();
    final doneIds = logs.where((l) => l.done).map((l) => l.habitId).toSet();

    final allCoreDone = coreHabits.every((h) => doneIds.contains(h.id));

    await db.into(db.dailyState).insertOnConflictUpdate(
          DailyStateCompanion(date: Value(dateKey), gatePassed: Value(allCoreDone)),
        );

    if (allCoreDone) {
      await streakEngine.markDayComplete(DateTime.now(), allCoreDone: true);
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
    final id = label.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    final existingCount = await db.select(db.habits).get().then((h) => h.length);
    await db.into(db.habits).insertOnConflictUpdate(
          HabitsCompanion(
            id: Value(id),
            label: Value(label),
            icon: Value(icon),
            tier: Value(tier),
            isCore: Value(isCore),
            sortOrder: Value(existingCount),
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
