import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../quicklog/data/quicklog_providers.dart';
import 'correlation_providers.dart';

const _uuid = Uuid();

class WeeklyStats {
  final int workoutsThisWeek;
  final int learningThisWeek;
  final double? avgSleepThisWeek;
  final int sleepEntriesThisWeek; // distinct days with a sleep entry
  final double? habitCompletionRate; // 0..1 across active habits, null if none
  final int socialSessions;
  final int funSessions;
  final double? avgEnergy; // 1..5
  const WeeklyStats({
    required this.workoutsThisWeek,
    required this.learningThisWeek,
    required this.avgSleepThisWeek,
    required this.sleepEntriesThisWeek,
    this.habitCompletionRate,
    this.socialSessions = 0,
    this.funSessions = 0,
    this.avgEnergy,
  });
}

/// Last-7-days rollup for the dashboard's weekly score. Reads QuickLogs (so
/// quick-capture entries count, not just the Track tabs) and re-computes
/// whenever any table it depends on changes.
final weeklyStatsProvider = StreamProvider<WeeklyStats>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateTime.parse(ref.watch(todayKeyProvider));
  final weekAgo = dateKeyOf(DateTime(today.year, today.month, today.day - 6));

  return watchTables(db, {db.quickLogs, db.hobbyLogs, db.habitLogs, db.habits}, () async {
    final logs = await (db.select(db.quickLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo))).get();
    final series = buildSeriesByType(logs);
    int count(QuickLogType t) => logs.where((l) => l.type == t.key).length;

    final sleepDays = series[QuickLogType.sleep]?.byDay.values.toList() ?? const <double>[];
    final energyLogs = logs.where((l) => l.type == QuickLogType.mood.key && l.value != null).map((l) => l.value!).toList();

    // Every hobby entry (Track tab or quick capture) is mirrored into
    // QuickLogs; only the Track tab records a category, so "social" comes
    // from there and everything else counts as fun.
    final socialHobbies = await (db.select(db.hobbyLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo) & t.category.equals('Social'))).get();
    final social = socialHobbies.length;

    final activeHabits = await (db.select(db.habits)..where((t) => t.archived.equals(false))).get();
    final activeIds = activeHabits.map((h) => h.id).toSet();
    final habitDone = await (db.select(db.habitLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo) & t.done.equals(true))).get();
    final doneCount = habitDone.where((l) => activeIds.contains(l.habitId)).length;

    return WeeklyStats(
      workoutsThisWeek: count(QuickLogType.exercise) + count(QuickLogType.martialArts),
      learningThisWeek: count(QuickLogType.learning),
      avgSleepThisWeek: sleepDays.isEmpty ? null : sleepDays.reduce((a, b) => a + b) / sleepDays.length,
      sleepEntriesThisWeek: sleepDays.length,
      habitCompletionRate: activeIds.isEmpty ? null : doneCount / (activeIds.length * 7),
      socialSessions: social,
      funSessions: (count(QuickLogType.hobby) - social).clamp(0, 1 << 30),
      avgEnergy: energyLogs.isEmpty ? null : energyLogs.reduce((a, b) => a + b) / energyLogs.length,
    );
  });
});

final reviewsProvider = StreamProvider<List<WeeklyReview>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.weeklyReviews)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> saveWeeklyReview(AppDatabase db, {required String date, String? win, String? adjust}) {
  return db.into(db.weeklyReviews).insert(
        WeeklyReviewsCompanion(id: Value(_uuid.v4()), date: Value(date), win: Value(win), adjust: Value(adjust)),
      );
}

/// One data point per day for the last 7 days, used to draw the sleep
/// trend chart on the dashboard. Missing days simply have a null value
/// and are skipped by the chart rather than plotted as zero.
class SleepTrendPoint {
  final DateTime date;
  final double? hours;
  const SleepTrendPoint({required this.date, required this.hours});
}

/// Reads sleep from QuickLogs, which covers both the Track → Sleep tab and
/// Today's quick numbers; several entries on one day are averaged.
final sleepTrendProvider = StreamProvider<List<SleepTrendPoint>>((ref) {
  final db = ref.watch(databaseProvider);
  final today = DateTime.parse(ref.watch(todayKeyProvider));
  final days = List.generate(7, (i) => DateTime(today.year, today.month, today.day - 6 + i));

  return (db.select(db.quickLogs)..where((t) => t.type.equals(QuickLogType.sleep.key) & t.date.isBiggerOrEqualValue(dateKeyOf(days.first)))).watch().map((logs) {
    final byDay = buildSeriesByType(logs)[QuickLogType.sleep]?.byDay ?? const {};
    return [for (final d in days) SleepTrendPoint(date: d, hours: byDay[d])];
  });
});
