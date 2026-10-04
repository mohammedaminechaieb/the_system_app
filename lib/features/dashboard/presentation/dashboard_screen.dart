import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/entry_toast.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/correlation_providers.dart';
import '../data/dashboard_providers.dart';

const _kQuickWins = ['Trained consistently', 'Slept well most nights', 'Tried a new class', 'Stuck to the plan', 'Good energy all week', 'Nailed the diet pattern'];
const _kQuickAdjusts = ['Sleep earlier', 'More cardio', 'Less screen time', 'Prep meals ahead', 'Plan the week on Sunday', 'Nothing — keep going'];

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String? _win;
  String? _adjust;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final streakAsync = ref.watch(streakStateStreamProvider);
    final statsAsync = ref.watch(weeklyStatsProvider);
    final reviewsAsync = ref.watch(reviewsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
        children: [
          streakAsync.when(
            data: (s) => Row(
              children: [
                Expanded(child: StatBox(value: '${s.currentStreak}', label: 'Day streak', icon: Icons.local_fire_department_rounded)),
                const SizedBox(width: 10),
                Expanded(child: StatBox(value: '${s.totalPoints}', label: 'Points', icon: Icons.bolt_rounded)),
                const SizedBox(width: 10),
                Expanded(child: StatBox(value: '${s.freezesAvailable}', label: 'Freezes', icon: Icons.ac_unit_rounded)),
              ],
            ),
            loading: () => const SizedBox(height: 70),
            error: (e, _) => Text('$e'),
          ),
          const SizedBox(height: AppSpacing.lg),

          const _SleepTrendCard(),
          const SizedBox(height: AppSpacing.lg),

          const _InsightsCard(),
          const SizedBox(height: AppSpacing.lg),

          statsAsync.when(
            data: (stats) => SectionCard(title: 'Weekly score', titleIcon: Icons.bar_chart, child: _ScoreBreakdown(stats: stats)),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('$e'),
          ),
          const SizedBox(height: AppSpacing.lg),

          streakAsync.when(
            data: (s) => SectionCard(
              title: 'Streak & penalty system',
              titleIcon: Icons.shield_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Every core habit completed today earns points immediately. Complete all of them and your streak grows. A freeze automatically absorbs one missed day — running out means a miss resets your streak.',
                  ),
                  const SizedBox(height: 10),
                  Pill(text: 'Longest streak: ${s.longestStreak} days', icon: Icons.emoji_events_outlined),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'Weekly review',
            titleIcon: Icons.rate_review_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PickerField<String>(
                  label: 'Biggest win this week',
                  value: _win,
                  leadingIcon: Icons.emoji_events_outlined,
                  options: [for (final w in _kQuickWins) PickerOption(value: w, label: w)],
                  onChanged: (v) => setState(() => _win = v),
                ),
                const SizedBox(height: 10),
                PickerField<String>(
                  label: 'What to adjust next week',
                  value: _adjust,
                  leadingIcon: Icons.tune,
                  options: [for (final a in _kQuickAdjusts) PickerOption(value: a, label: a)],
                  onChanged: (v) => setState(() => _adjust = v),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_win == null && _adjust == null)
                        ? null
                        : () {
                            saveWeeklyReview(db, date: todayKey, win: _win, adjust: _adjust);
                            showEntryAddedToast(context, message: 'Review saved', icon: Icons.rate_review);
                            setState(() {
                              _win = null;
                              _adjust = null;
                            });
                          },
                    child: const Text('Save review'),
                  ),
                ),
                const SizedBox(height: 14),
                reviewsAsync.when(
                  data: (reviews) => Column(
                    children: [
                      for (final r in reviews.take(5))
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.borderSoft))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(r.date, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 10.5, color: p.textFaint)),
                              if (r.win?.isNotEmpty == true) Padding(padding: const EdgeInsets.only(top: 3), child: Text('Win: ${r.win}', style: const TextStyle(fontSize: 12.5))),
                              if (r.adjust?.isNotEmpty == true) Padding(padding: const EdgeInsets.only(top: 2), child: Text('Adjust: ${r.adjust}', style: const TextStyle(fontSize: 12.5))),
                            ],
                          ),
                        ),
                    ],
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cross-domain correlation insights — computed locally and entirely from
/// the person's own QuickLog history, no AI involved. See
/// dashboard/data/correlation_providers.dart for the pure-Dart statistics.
class _InsightsCard extends ConsumerWidget {
  const _InsightsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);

    return SectionCard(
      title: 'Patterns in your data',
      titleIcon: Icons.insights_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final insight in insights)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CalloutBox(icon: Icons.trending_up_rounded, text: '${insight.title}: ${insight.body}'),
            ),
        ],
      ),
    );
  }
}

class _ScoreBreakdown extends StatelessWidget {
  final WeeklyStats stats;
  const _ScoreBreakdown({required this.stats});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final sleepOk = stats.avgSleepThisWeek != null && stats.avgSleepThisWeek! >= 7;
    final categories = [
      ('Health (sleep+rest)', 25.0, sleepOk ? 25.0 : (stats.avgSleepThisWeek != null ? 14.0 : 0.0)),
      ('Fitness (capped at plan)', 20.0, (stats.workoutsThisWeek.clamp(0, 4) / 4) * 20),
      ('Sleep consistency', 15.0, stats.sleepEntriesThisWeek >= 5 ? 15.0 : stats.sleepEntriesThisWeek * 3.0),
      ('Learning', 15.0, (stats.learningThisWeek.clamp(0, 5) / 5) * 15),
      ('Habits completed', 10.0, (stats.habitCompletionRate ?? 0).clamp(0.0, 1.0) * 10),
      ('Social', 5.0, stats.socialSessions >= 1 ? 5.0 : 0.0),
      ('Fun (hobby time)', 5.0, (stats.funSessions.clamp(0, 2) / 2) * 5),
      ('Recovery (avg energy)', 5.0, stats.avgEnergy == null ? 0.0 : ((stats.avgEnergy! - 1) / 2).clamp(0.0, 1.0) * 5),
    ];
    final total = categories.fold<double>(0, (sum, c) => sum + c.$3).round();

    return Column(
      children: [
        for (final c in categories)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.$1, style: const TextStyle(fontSize: 12.5)),
                    Text('${c.$3.round()}/${c.$2.round()}', style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 11.5)),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(borderRadius: BorderRadius.circular(3), child: LinearProgressIndicator(value: c.$3 / c.$2, minHeight: 6)),
              ],
            ),
          ),
        Divider(height: 24, color: p.borderSoft),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            Text('$total / 100', style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 20, fontWeight: FontWeight.w700, color: p.primary)),
          ],
        ),
      ],
    );
  }
}

/// A 7-day sleep trend line chart — replaces what would otherwise be another
/// row of numbers with something genuinely readable at a glance: is sleep
/// trending up, down, or steady this week.
class _SleepTrendCard extends ConsumerWidget {
  const _SleepTrendCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final trendAsync = ref.watch(sleepTrendProvider);

    return SectionCard(
      title: 'Sleep trend (7 days)',
      titleIcon: Icons.bedtime_outlined,
      child: trendAsync.when(
        data: (points) {
          final hasAnyData = points.any((pt) => pt.hours != null);
          if (!hasAnyData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.nightlight_outlined, size: 28, color: p.textFaint),
                    const SizedBox(height: 8),
                    Text('Log a few nights of sleep to see your trend here.', style: TextStyle(color: p.textFaint, fontSize: 12.5), textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          final spots = <FlSpot>[];
          for (int i = 0; i < points.length; i++) {
            if (points[i].hours != null) spots.add(FlSpot(i.toDouble(), points[i].hours!));
          }

          return SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 10,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2.5,
                  getDrawingHorizontalLine: (_) => FlLine(color: p.borderSoft, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 2.5, reservedSize: 28, getTitlesWidget: (v, meta) => Text('${v.toInt()}h', style: TextStyle(fontSize: 9.5, color: p.textFaint))),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (v, meta) {
                        final idx = v.toInt();
                        if (idx < 0 || idx >= points.length) return const SizedBox.shrink();
                        const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                        final weekday = points[idx].date.weekday - 1;
                        return Padding(padding: const EdgeInsets.only(top: 6), child: Text(labels[weekday], style: TextStyle(fontSize: 10, color: p.textFaint, fontWeight: FontWeight.w600)));
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    color: p.primary,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(radius: 4, color: p.primary, strokeWidth: 2, strokeColor: p.surfaceRaised),
                    ),
                    belowBarData: BarAreaData(show: true, color: p.primary.withValues(alpha: 0.12)),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}
