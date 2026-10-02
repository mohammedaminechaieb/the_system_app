import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';

const _uuid = Uuid();

/// The fixed set of quick-log categories used across the quick-capture
/// sheet, the correlation engine, and every domain screen that also writes
/// a QuickLog row alongside its own detailed table.
enum QuickLogType { exercise, meal, hobby, sleep, mood, habit, learning, martialArts, weight }

extension QuickLogTypeX on QuickLogType {
  String get key => switch (this) {
        QuickLogType.exercise => 'exercise',
        QuickLogType.meal => 'meal',
        QuickLogType.hobby => 'hobby',
        QuickLogType.sleep => 'sleep',
        QuickLogType.mood => 'mood',
        QuickLogType.habit => 'habit',
        QuickLogType.learning => 'learning',
        QuickLogType.martialArts => 'martial_arts',
        QuickLogType.weight => 'weight',
      };

  String get label => switch (this) {
        QuickLogType.exercise => 'Exercise',
        QuickLogType.meal => 'Meal',
        QuickLogType.hobby => 'Hobby',
        QuickLogType.sleep => 'Sleep',
        QuickLogType.mood => 'Mood',
        QuickLogType.habit => 'Habit',
        QuickLogType.learning => 'Learning',
        QuickLogType.martialArts => 'Martial arts',
        QuickLogType.weight => 'Weight',
      };

  String get defaultUnit => switch (this) {
        QuickLogType.exercise => 'minutes',
        QuickLogType.meal => 'kcal',
        QuickLogType.hobby => 'minutes',
        QuickLogType.sleep => 'hours',
        QuickLogType.mood => 'level',
        QuickLogType.habit => 'done',
        QuickLogType.learning => 'minutes',
        QuickLogType.martialArts => 'minutes',
        QuickLogType.weight => 'kg',
      };
}

/// All quick logs, most recent first. The single source powering the
/// dashboard's correlation engine (see dashboard/data/correlation_providers.dart).
final quickLogsProvider = StreamProvider<List<QuickLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quickLogs)..orderBy([(t) => OrderingTerm.desc(t.timestamp)])).watch();
});

/// Quick logs within the last [days] days — the window most dashboard
/// rollups and correlations care about, kept as its own provider so screens
/// don't all recompute the same date cutoff independently.
final recentQuickLogsProvider = StreamProvider.family<List<QuickLog>, int>((ref, days) {
  final db = ref.watch(databaseProvider);
  final cutoff = DateTime.now().subtract(Duration(days: days)).toIso8601String().substring(0, 10);
  return (db.select(db.quickLogs)
        ..where((t) => t.date.isBiggerOrEqualValue(cutoff))
        ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
      .watch();
});

class QuickLogActions {
  final AppDatabase db;
  QuickLogActions(this.db);

  Future<void> add({
    required QuickLogType type,
    String? subtype,
    double? value,
    String? unit,
    int? mood,
    String? note,
    required String dateKey,
  }) async {
    await db.into(db.quickLogs).insert(
          QuickLogsCompanion(
            id: Value(_uuid.v4()),
            type: Value(type.key),
            subtype: Value(subtype),
            value: Value(value),
            unit: Value(unit ?? type.defaultUnit),
            mood: Value(mood),
            note: Value(note),
            date: Value(dateKey),
          ),
        );

    // Screen-time-as-currency: extends the streak/penalty engine rather
    // than replacing it (see StreakEngine.earnScreenTimeMinutes). Only
    // duration-bearing activity categories and habit ticks earn minutes —
    // logging mood/weight/a meal doesn't unlock screen time.
    const earningTypes = {QuickLogType.exercise, QuickLogType.hobby, QuickLogType.learning, QuickLogType.martialArts};
    if (earningTypes.contains(type) && (value ?? 0) > 0) {
      await StreakEngine(db).earnScreenTimeMinutes(dateKey, value!);
    } else if (type == QuickLogType.habit) {
      await StreakEngine(db).earnScreenTimeMinutes(dateKey, 10); // flat 10 "minutes" for a habit tick
    }
  }

  Future<void> delete(String id) => (db.delete(db.quickLogs)..where((t) => t.id.equals(id))).go();

  /// Looks at the last 14 days of entries and returns the most frequently
  /// logged type, so the quick-capture sheet can default to it instead of
  /// making every entry start from a blank picker. Falls back to
  /// [QuickLogType.exercise] when there's no history yet.
  Future<QuickLogType> suggestLikelyType() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 14)).toIso8601String().substring(0, 10);
    final rows = await (db.select(db.quickLogs)..where((t) => t.date.isBiggerOrEqualValue(cutoff))).get();
    if (rows.isEmpty) return QuickLogType.exercise;

    final counts = <String, int>{};
    for (final r in rows) {
      counts[r.type] = (counts[r.type] ?? 0) + 1;
    }
    final topKey = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    return QuickLogType.values.firstWhere((t) => t.key == topKey, orElse: () => QuickLogType.exercise);
  }
}

final quickLogActionsProvider = Provider<QuickLogActions>((ref) {
  final db = ref.watch(databaseProvider);
  return QuickLogActions(db);
});
