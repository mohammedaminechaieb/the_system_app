import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_system/core/database/app_database.dart';
import 'package:the_system/core/providers/streak_engine.dart';
import 'package:the_system/features/habits/data/habits_providers.dart';
import 'package:the_system/features/quicklog/data/quicklog_providers.dart';
import 'package:the_system/features/track/data/track_providers.dart';

void main() {
  late AppDatabase db;
  late StreakEngine engine;
  late HabitActions habits;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    engine = StreakEngine(db);
    habits = HabitActions(db, engine);
  });
  tearDown(() => db.close());

  Future<StreakStateData> state() => (db.select(db.streakState)..where((t) => t.id.equals(0))).getSingle();
  Future<int> credits(String day) async => (await (db.select(db.screenTimeCredits)..where((t) => t.date.equals(day))).getSingleOrNull())?.earnedMinutes ?? 0;

  test('tick then untick leaves points, logs and screen time unchanged', () async {
    const day = '2026-03-10';
    for (var i = 0; i < 3; i++) {
      await habits.toggle('meditated', day);
      await habits.toggle('meditated', day);
    }
    expect((await state()).totalPoints, 0);
    expect(await credits(day), 0);
    expect(await db.select(db.quickLogs).get(), isEmpty);
  });

  test('relaunching the app does not charge the same missed days twice', () async {
    await (db.update(db.streakState)..where((t) => t.id.equals(0))).write(
      const StreakStateCompanion(currentStreak: Value(4), totalPoints: Value(100), streakFreezesAvailable: Value(0), lastCompletedDate: Value('2026-03-05')),
    );
    final now = DateTime(2026, 3, 10, 9);
    await engine.reconcileOnLaunch(now);
    final afterFirst = await state();
    expect(afterFirst.currentStreak, 0);
    expect(afterFirst.totalPoints, 100 + StreakRules.penaltyPerMissedDay * 4);

    await engine.reconcileOnLaunch(now.add(const Duration(hours: 3)));
    expect((await state()).totalPoints, afterFirst.totalPoints);
  });

  test('today habits stream updates when a habit is ticked', () async {
    const day = '2026-03-10';
    final stream = watchTodayHabits(db, day);
    final emissions = <List<HabitWithStatus>>[];
    final sub = stream.listen(emissions.add);
    await pumpEventQueue();
    await habits.toggle('read', day);
    await pumpEventQueue();
    await sub.cancel();
    expect(emissions.first.firstWhere((h) => h.habit.id == 'read').done, isFalse);
    expect(emissions.last.firstWhere((h) => h.habit.id == 'read').done, isTrue);
  });

  test('deleting a tracked entry removes its quick-log mirror and screen-time credit', () async {
    const day = '2026-03-10';
    await addExerciseLog(db, date: day, type: 'Run', durationMin: 20);
    expect(await credits(day), 30);
    final row = (await db.select(db.exerciseLogs).get()).single;
    await deleteLogRow(db, 'exercise', row.id);
    expect(await db.select(db.quickLogs).get(), isEmpty);
    expect(await credits(day), 0);
  });

  test('ticking every core habit passes the gate and grows the streak once', () async {
    final today = DateTime.now();
    final day = '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    for (final id in ['trained', 'meditated', 'slept_on_time', 'read']) {
      await habits.toggle(id, day);
    }
    final s = await state();
    expect(s.currentStreak, 1);
    expect(s.lastCompletedDate, day);
    expect(s.totalPoints, 4 * StreakRules.pointsPerCoreHabitDone + StreakRules.pointsFullDayBonus);
    final gate = await (db.select(db.dailyState)..where((t) => t.date.equals(day))).getSingle();
    expect(gate.gatePassed, isTrue);

    // Untick + retick: points return to the same total, streak doesn't double count.
    await habits.toggle('read', day);
    await habits.toggle('read', day);
    expect((await state()).currentStreak, 1);
    expect((await state()).totalPoints, s.totalPoints);
  });

  test('replaceForDay keeps a single energy reading per day', () async {
    const day = '2026-03-10';
    final logs = QuickLogActions(db);
    for (final level in [2, 3, 5]) {
      await logs.replaceForDay(type: QuickLogType.mood, subtype: 'energy', value: level.toDouble(), dateKey: day);
    }
    final rows = await db.select(db.quickLogs).get();
    expect(rows.single.value, 5);
  });
}
