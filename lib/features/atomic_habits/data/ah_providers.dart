import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';

final readingProgressProvider = StreamProvider<Map<String, ReadingProgressData>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.readingProgress).watch().map(
        (rows) => {for (final r in rows) r.chapterId: r},
      );
});

class ReadingActions {
  final AppDatabase db;
  ReadingActions(this.db);

  Future<void> markCompleted(String chapterId) async {
    await db.into(db.readingProgress).insertOnConflictUpdate(
          ReadingProgressCompanion(
            chapterId: Value(chapterId),
            completed: const Value(true),
            completedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> saveLastPage(String chapterId, int pageIndex) async {
    await db.into(db.readingProgress).insertOnConflictUpdate(
          ReadingProgressCompanion(
            chapterId: Value(chapterId),
            lastPageIndex: Value(pageIndex),
          ),
        );
  }
}

final readingActionsProvider = Provider<ReadingActions>((ref) {
  final db = ref.watch(databaseProvider);
  return ReadingActions(db);
});
