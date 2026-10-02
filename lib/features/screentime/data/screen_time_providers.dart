import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';
import '../../today/data/today_providers.dart';

final blockedAppsProvider = StreamProvider<List<BlockedApp>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.blockedApps)..orderBy([(t) => OrderingTerm(expression: t.label)])).watch();
});

final todayScreenTimeCreditsProvider = StreamProvider<ScreenTimeCredit?>((ref) {
  final db = ref.watch(databaseProvider);
  final todayKey = ref.watch(todayKeyProvider);
  return (db.select(db.screenTimeCredits)..where((t) => t.date.equals(todayKey))).watchSingleOrNull();
});

class ScreenTimeManagement {
  final AppDatabase db;
  ScreenTimeManagement(this.db);

  Future<void> addBlockedApp(String packageName, String label) {
    return db.into(db.blockedApps).insertOnConflictUpdate(
          BlockedAppsCompanion(packageName: Value(packageName), label: Value(label)),
        );
  }

  Future<void> removeBlockedApp(String packageName) => (db.delete(db.blockedApps)..where((t) => t.packageName.equals(packageName))).go();

  Future<void> setEnabled(String packageName, bool enabled) =>
      (db.update(db.blockedApps)..where((t) => t.packageName.equals(packageName))).write(BlockedAppsCompanion(enabled: Value(enabled)));

  Future<int> redeemMinutes(String dateKey, int minutes) => StreakEngine(db).redeemScreenTimeMinutes(dateKey, minutes);
}

final screenTimeManagementProvider = Provider<ScreenTimeManagement>((ref) {
  final db = ref.watch(databaseProvider);
  return ScreenTimeManagement(db);
});
