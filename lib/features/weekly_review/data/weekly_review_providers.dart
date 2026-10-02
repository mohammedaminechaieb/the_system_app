import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ai/gemini_service.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../dashboard/data/correlation_providers.dart';
import '../../quicklog/data/quicklog_providers.dart';

/// Monday of the current week, as a yyyy-MM-dd key — the identity for a
/// cached AI weekly review.
String currentWeekStartKey() {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return '${monday.year.toString().padLeft(4, '0')}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
}

/// The cached review for the current week, if one has already been
/// generated — null means "not generated yet", which the screen treats as
/// "show a generate button", not an error.
final cachedWeeklyReviewProvider = StreamProvider<AiWeeklyReview?>((ref) {
  final db = ref.watch(databaseProvider);
  final weekStart = currentWeekStartKey();
  return (db.select(db.aiWeeklyReviews)..where((t) => t.weekStart.equals(weekStart))).watchSingleOrNull();
});

class WeeklyReviewActions {
  final Ref ref;
  WeeklyReviewActions(this.ref);

  AppDatabase get _db => ref.read(databaseProvider);

  /// Builds a short aggregated (not raw-dump) summary of the last 7 days
  /// from QuickLogs plus whatever correlation insights are currently
  /// available, and asks Gemini for a specific, coaching-style review.
  /// Caches the result — call again explicitly to refresh; nothing here
  /// re-calls the API automatically.
  Future<String?> generate() async {
    final logs = await ref.read(quickLogsProvider.future);
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    final weekLogs = logs.where((l) => DateTime.parse(l.date).isAfter(cutoff)).toList();

    final byType = <String, List<QuickLog>>{};
    for (final l in weekLogs) {
      byType.putIfAbsent(l.type, () => []).add(l);
    }

    final statLines = <String>[];
    byType.forEach((type, entries) {
      final total = entries.fold<double>(0, (sum, e) => sum + (e.value ?? 1));
      final days = entries.map((e) => e.date).toSet().length;
      statLines.add('$type: $days day(s) logged, total value ~${total.toStringAsFixed(1)} (unit: ${entries.first.unit ?? 'count'})');
    });

    final insights = ref.read(insightsProvider);
    final insightLines = insights.map((i) => '${i.title}: ${i.body}').toList();

    final prompt = '''
You are a blunt, specific personal coach reviewing one week of a person's
own self-tracked data from their private habit-tracking app. Do NOT give
generic motivational fluff ("you're doing great, keep it up!") — reference
the actual numbers and patterns below directly, the way a good coach who
has actually looked at the data would. 3-5 short sentences max. If the data
is thin, say so plainly instead of inventing detail.

This week's aggregated stats:
${statLines.isEmpty ? '(no entries logged this week)' : statLines.join('\n')}

Patterns detected across the data:
${insightLines.isEmpty ? '(none detected yet — not enough data)' : insightLines.join('\n')}
''';

    final result = await GeminiService.instance.generateText(prompt);
    if (result == null) return null;

    await _db.into(_db.aiWeeklyReviews).insertOnConflictUpdate(
          AiWeeklyReviewsCompanion(
            weekStart: Value(currentWeekStartKey()),
            content: Value(result),
          ),
        );
    return result;
  }
}

final weeklyReviewActionsProvider = Provider((ref) => WeeklyReviewActions(ref));
