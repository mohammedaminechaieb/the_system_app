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
    await QuickLogActions(db).add(type: QuickLogType.mood, value: level.toDouble(), unit: 'level', dateKey: dateKey);
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
      await QuickLogActions(db).add(type: QuickLogType.sleep, value: sleepHours, unit: 'hours', dateKey: dateKey);
    }
    if (weightKg != null) {
      await QuickLogActions(db).add(type: QuickLogType.weight, value: weightKg, unit: 'kg', dateKey: dateKey);
    }
  }
}

final dailyStateActionsProvider = Provider<DailyStateActions>((ref) {
  final db = ref.watch(databaseProvider);
  return DailyStateActions(db);
});
