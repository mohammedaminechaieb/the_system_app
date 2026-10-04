import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../quicklog/data/quicklog_providers.dart';

final todayStateProvider = StreamProvider<DailyStateData?>((ref) {
  final db = ref.watch(databaseProvider);
  final todayKey = ref.watch(todayKeyProvider);
  return (db.select(db.dailyState)..where((t) => t.date.equals(todayKey))).watchSingleOrNull();
});

class DailyStateActions {
  final AppDatabase db;
  DailyStateActions(this.db);

  Future<void> setEnergy(String dateKey, int level) async {
    await db.into(db.dailyState).insertOnConflictUpdate(
          DailyStateCompanion(date: Value(dateKey), energyLevel: Value(level)),
        );
    // One energy reading per day — changing it replaces the earlier one
    // rather than stacking extra mood entries into the correlations.
    await QuickLogActions(db).replaceForDay(type: QuickLogType.mood, subtype: 'energy', value: level.toDouble(), unit: 'level', mood: level, dateKey: dateKey);
  }

  Future<void> setQuickLog(String dateKey, {double? sleepHours, double? weightKg, int? steps}) async {
    await db.into(db.dailyState).insertOnConflictUpdate(
          DailyStateCompanion(
            date: Value(dateKey),
            sleepHours: sleepHours != null ? Value(sleepHours) : const Value.absent(),
            weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
            steps: steps != null ? Value(steps) : const Value.absent(),
          ),
        );
    if (sleepHours != null) {
      await QuickLogActions(db).replaceForDay(type: QuickLogType.sleep, subtype: 'daily', value: sleepHours, unit: 'hours', dateKey: dateKey);
    }
    if (weightKg != null) {
      await QuickLogActions(db).replaceForDay(type: QuickLogType.weight, subtype: 'daily', value: weightKg, unit: 'kg', dateKey: dateKey);
    }
  }
}

/// Most recent known body weight (weigh-ins or the daily quick log), used to
/// start weight steppers near the real value instead of a generic 70 kg.
final latestWeightProvider = StreamProvider<double?>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quickLogs)
        ..where((t) => t.type.equals(QuickLogType.weight.key) & t.value.isNotNull())
        ..orderBy([(t) => OrderingTerm.desc(t.date), (t) => OrderingTerm.desc(t.timestamp)])
        ..limit(1))
      .watchSingleOrNull()
      .map((row) => row?.value);
});

final dailyStateActionsProvider = Provider<DailyStateActions>((ref) {
  final db = ref.watch(databaseProvider);
  return DailyStateActions(db);
});
