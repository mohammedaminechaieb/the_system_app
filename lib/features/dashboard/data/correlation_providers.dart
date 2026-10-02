import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_system/core/database/app_database.dart';

import '../../quicklog/data/quicklog_providers.dart';


/// A per-day rollup of one QuickLogType's total/average value, used for
/// rolling averages and as the aligned series correlation is computed over.
class DailySeries {
  final Map<DateTime, double> byDay; // day (midnight, local) -> summed value
  const DailySeries(this.byDay);

  double? averageOverLastDays(int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final values = byDay.entries.where((e) => e.key.isAfter(cutoff)).map((e) => e.value).toList();
    if (values.isEmpty) return null;
    return values.reduce((a, b) => a + b) / values.length;
  }
}

class RollingAverages {
  final double? sevenDay;
  final double? thirtyDay;
  const RollingAverages({this.sevenDay, this.thirtyDay});
}

class InsightCard {
  final String title;
  final String body;
  const InsightCard({required this.title, required this.body});
}

/// Builds one [DailySeries] per QuickLogType from a flat list of logs,
/// summing same-day same-type entries (e.g. two workouts logged the same
/// day count as one combined day for rolling-average purposes).
Map<QuickLogType, DailySeries> _buildSeriesByType(List<QuickLog> logs) {
  final grouped = <QuickLogType, Map<DateTime, double>>{};
  for (final log in logs) {
    final type = QuickLogType.values.firstWhere((t) => t.key == log.type, orElse: () => QuickLogType.exercise);
    final day = DateTime.parse(log.date);
    final map = grouped.putIfAbsent(type, () => {});
    map[day] = (map[day] ?? 0) + (log.value ?? 1); // count as 1 if no numeric value (e.g. a habit tick)
  }
  return grouped.map((k, v) => MapEntry(k, DailySeries(v)));
}

/// Rolling 7/30-day averages per category, recomputed whenever the
/// underlying QuickLogs change. Empty map while the initial load is still
/// in flight or if it errors — callers treat that the same as "no data
/// yet" rather than needing separate loading/error handling here.
final rollingAveragesProvider = Provider<Map<QuickLogType, RollingAverages>>((ref) {
  final logs = ref.watch(quickLogsProvider).valueOrNull ?? const [];
  final series = _buildSeriesByType(logs);
  return {
    for (final entry in series.entries)
      entry.key: RollingAverages(sevenDay: entry.value.averageOverLastDays(7), thirtyDay: entry.value.averageOverLastDays(30)),
  };
});

/// Pearson correlation coefficient between two aligned day-value series,
/// using only days present in both. Returns null if there isn't enough
/// overlapping data (fewer than 4 shared days) to say anything meaningful.
double? pearsonCorrelation(Map<DateTime, double> a, Map<DateTime, double> b) {
  final sharedDays = a.keys.toSet().intersection(b.keys.toSet());
  if (sharedDays.length < 4) return null;

  final xs = sharedDays.map((d) => a[d]!).toList();
  final ys = sharedDays.map((d) => b[d]!).toList();
  final n = xs.length;

  final meanX = xs.reduce((p, q) => p + q) / n;
  final meanY = ys.reduce((p, q) => p + q) / n;

  double covariance = 0, varX = 0, varY = 0;
  for (var i = 0; i < n; i++) {
    final dx = xs[i] - meanX;
    final dy = ys[i] - meanY;
    covariance += dx * dy;
    varX += dx * dx;
    varY += dy * dy;
  }
  if (varX == 0 || varY == 0) return null; // no variance — correlation undefined
  return covariance / (_sqrt(varX) * _sqrt(varY));
}

double _sqrt(double v) {
  if (v <= 0) return 0;
  double x = v, y = 1, e = 0.0000001;
  while (x - y > e) {
    x = (x + y) / 2;
    y = v / x;
  }
  return x;
}

/// One correlation pair worth surfacing, with a human-readable label.
class _CorrelationPair {
  final QuickLogType a;
  final QuickLogType b;
  final String aLabel;
  final String bLabel;
  const _CorrelationPair(this.a, this.b, this.aLabel, this.bLabel);
}

const _kInterestingPairs = [
  _CorrelationPair(QuickLogType.sleep, QuickLogType.exercise, 'sleep', 'exercise'),
  _CorrelationPair(QuickLogType.sleep, QuickLogType.mood, 'sleep', 'mood'),
  _CorrelationPair(QuickLogType.mood, QuickLogType.martialArts, 'mood', 'martial arts sessions'),
  _CorrelationPair(QuickLogType.exercise, QuickLogType.mood, 'exercise', 'mood'),
  _CorrelationPair(QuickLogType.sleep, QuickLogType.learning, 'sleep', 'learning'),
];

/// Auto-generated insight cards for the dashboard — 2-3 short, specific
/// observations computed purely from local data (no AI). Recomputed
/// whenever QuickLogs change; screens can also force a refresh by simply
/// re-reading this provider (it's not cached beyond Riverpod's own
/// caching, so "on-demand" here just means "always current").
final insightsProvider = Provider<List<InsightCard>>((ref) {
  final logs = ref.watch(quickLogsProvider).valueOrNull ?? const [];
  final series = _buildSeriesByType(logs);
  final insights = <InsightCard>[];

  for (final pair in _kInterestingPairs) {
    final seriesA = series[pair.a];
    final seriesB = series[pair.b];
    if (seriesA == null || seriesB == null) continue;
    final r = pearsonCorrelation(seriesA.byDay, seriesB.byDay);
    if (r == null) continue;
    if (r.abs() < 0.3) continue; // too weak to be worth surfacing

    final strength = r.abs() >= 0.6 ? 'a strong' : 'a noticeable';
    final direction = r > 0 ? 'higher' : 'lower';
    insights.add(InsightCard(
      title: '${_titleCase(pair.aLabel)} & ${pair.bLabel}',
      body: 'There\'s $strength link between your ${pair.aLabel} and ${pair.bLabel} — days with more ${pair.aLabel} tend to come with $direction ${pair.bLabel}.',
    ));
    if (insights.length >= 3) break;
  }

  if (insights.isEmpty && logs.length < 10) {
    insights.add(const InsightCard(
      title: 'Not enough data yet',
      body: 'Keep logging for a couple of weeks and this card will start surfacing real patterns from your own data.',
    ));
  }

  return insights;
});

String _titleCase(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
