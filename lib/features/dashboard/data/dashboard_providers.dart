import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';

const _uuid = Uuid();

class WeeklyStats {
  final int workoutsThisWeek;
  final int learningThisWeek;
  final double? avgSleepThisWeek;
  final int sleepEntriesThisWeek;
  const WeeklyStats({
    required this.workoutsThisWeek,
    required this.learningThisWeek,
    required this.avgSleepThisWeek,
    required this.sleepEntriesThisWeek,
  });
}

final weeklyStatsProvider = StreamProvider<WeeklyStats>((ref) {
  final db = ref.watch(databaseProvider);
  final weekAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String().substring(0, 10);

  final exerciseStream = (db.select(db.exerciseLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo))).watch();
  final learningStream = (db.select(db.learningLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo))).watch();
  final sleepStream = (db.select(db.sleepLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgo))).watch();

  return exerciseStream.asyncMap((exLogs) async {
    final learnLogs = await learningStream.first;
    final sleepLogs = await sleepStream.first;
    final validSleep = sleepLogs.where((s) => s.hours != null).map((s) => s.hours!).toList();
    final avg = validSleep.isEmpty ? null : validSleep.reduce((a, b) => a + b) / validSleep.length;
    return WeeklyStats(
      workoutsThisWeek: exLogs.length,
      learningThisWeek: learnLogs.length,
      avgSleepThisWeek: avg,
      sleepEntriesThisWeek: validSleep.length,
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

final sleepTrendProvider = StreamProvider<List<SleepTrendPoint>>((ref) {
  final db = ref.watch(databaseProvider);
  final weekAgo = DateTime.now().subtract(const Duration(days: 6));
  final weekAgoKey = weekAgo.toIso8601String().substring(0, 10);

  return (db.select(db.sleepLogs)..where((t) => t.date.isBiggerOrEqualValue(weekAgoKey))).watch().map((logs) {
    final byDate = <String, double>{};
    for (final l in logs) {
      if (l.hours != null) byDate[l.date] = l.hours!;
    }
    return List.generate(7, (i) {
      final d = weekAgo.add(Duration(days: i));
      final key = d.toIso8601String().substring(0, 10);
      return SleepTrendPoint(date: d, hours: byDate[key]);
    });
  });
});
