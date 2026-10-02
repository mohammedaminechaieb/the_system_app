import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/animated_habit_check.dart';
import '../../../core/widgets/net_image.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../habits/data/habits_providers.dart';
import '../../quicklog/presentation/quick_capture_sheet.dart';
import '../data/today_providers.dart';
import '../domain/plan_content.dart';

const _kMorningImg = 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=900&q=80';
const _kEveningImg = 'https://images.unsplash.com/photo-1483721310020-03333e577078?w=900&q=80';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final now = ref.watch(todayTickerProvider);
    final season = ref.watch(seasonProvider);
    final todayKey = ref.watch(todayKeyProvider);
    final dayPlan = PlanContent.todayPlan(season, now);
    final dateLabel = DateFormat('EEEE, d MMMM').format(now);
    final habitsAsync = ref.watch(todayHabitsProvider);
    final stateAsync = ref.watch(todayStateProvider);
    final isDayTime = now.hour >= 6 && now.hour < 18;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showQuickCaptureSheet(context, ref),
        icon: const Icon(Icons.bolt_rounded),
        label: const Text('Quick log'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            backgroundColor: p.bg,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
              title: Text(dateLabel, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  NetImage(url: isDayTime ? _kMorningImg : _kEveningImg, fallbackIcon: Icons.wb_sunny_rounded, fit: BoxFit.cover, borderRadius: BorderRadius.zero),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.55)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 6),
                child: SeasonBadge(
                  season: season,
                  onTap: () => ref.read(seasonProvider.notifier).state = season == Season.summer ? Season.winter : Season.summer,
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 90),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SectionCard(
                  title: "Today's plan",
                  titleIcon: Icons.map_outlined,
                  trailing: Pill(text: season == Season.summer ? 'Summer' : 'Winter', icon: season == Season.summer ? Icons.wb_sunny_rounded : Icons.ac_unit_rounded),
                  child: BulletList(items: dayPlan.items, gap: 7),
                ),
                const SizedBox(height: AppSpacing.lg),

                SectionCard(
                  title: "Today's habits",
                  titleIcon: Icons.check_circle_outline,
                  trailing: habitsAsync.maybeWhen(
                    data: (h) => Pill(text: '${h.where((x) => x.done).length}/${h.length}'),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  child: habitsAsync.when(
                    data: (habits) => Column(
                      children: [for (final h in habits) _HabitRow(habitId: h.habit.id, label: h.habit.label, done: h.done, streak: h.streakDays, tier: h.habit.tier)],
                    ),
                    loading: () => const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
                    error: (e, _) => Text('$e'),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                SectionCard(
                  title: 'Quick log',
                  titleIcon: Icons.speed_outlined,
                  child: stateAsync.when(
                    data: (state) => _QuickLogPickers(todayKey: todayKey, initialSleep: state?.sleepHours, initialWeight: state?.weightKg, initialSteps: state?.steps),
                    loading: () => const SizedBox.shrink(),
                    error: (e, _) => Text('$e'),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                CalloutBox(
                  icon: Icons.favorite_border,
                  text: "Rough day? 5 minutes of movement is enough — that still counts. See Reference → Getting Started.",
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class SeasonBadge extends StatelessWidget {
  final Season season;
  final VoidCallback onTap;
  const SeasonBadge({super.key, required this.season, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSummer = season == Season.summer;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSummer ? Icons.wb_sunny_rounded : Icons.ac_unit_rounded, size: 13, color: Colors.white),
            const SizedBox(width: 5),
            Text(isSummer ? 'SUMMER' : 'WINTER', style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _HabitRow extends ConsumerWidget {
  final String habitId;
  final String label;
  final bool done;
  final int streak;
  final int tier;
  const _HabitRow({required this.habitId, required this.label, required this.done, required this.streak, this.tier = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final todayKey = ref.watch(todayKeyProvider);
    return InkWell(
      onTap: () => ref.read(habitActionsProvider).toggle(habitId, todayKey),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            AnimatedHabitCheck(done: done, onTap: () => ref.read(habitActionsProvider).toggle(habitId, todayKey)),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
            if (tier > 1) Padding(padding: const EdgeInsets.only(right: 6), child: Icon(Icons.whatshot_rounded, size: 14, color: tier == 3 ? p.danger : p.warning)),
            if (streak > 0) Pill(text: '${streak}d', icon: Icons.local_fire_department_rounded),
          ],
        ),
      ),
    );
  }
}

/// Replaces the old free-text quick-log fields with pickers/steppers —
/// nothing here requires typing on a phone keyboard.
class _QuickLogPickers extends ConsumerStatefulWidget {
  final String todayKey;
  final double? initialSleep;
  final double? initialWeight;
  final int? initialSteps;
  const _QuickLogPickers({required this.todayKey, this.initialSleep, this.initialWeight, this.initialSteps});

  @override
  ConsumerState<_QuickLogPickers> createState() => _QuickLogPickersState();
}

class _QuickLogPickersState extends ConsumerState<_QuickLogPickers> {
  double? _sleep;
  double? _weight;
  int? _steps;

  static const _sleepPresets = [4.0, 5.0, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 10.0];
  static const _stepPresets = [2000, 4000, 6000, 8000, 10000, 12000, 15000, 20000];

  @override
  void initState() {
    super.initState();
    _sleep = widget.initialSleep;
    _weight = widget.initialWeight;
    _steps = widget.initialSteps;
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PickerField<double>(
          label: 'Slept (hours)',
          value: _sleep,
          leadingIcon: Icons.bedtime_outlined,
          options: [for (final h in _sleepPresets) PickerOption(value: h, label: '$h h', icon: Icons.bedtime_outlined)],
          onChanged: (v) => setState(() => _sleep = v),
        ),
        const SizedBox(height: 10),
        _WeightStepper(
          value: _weight,
          onChanged: (v) => setState(() => _weight = v),
        ),
        const SizedBox(height: 10),
        PickerField<int>(
          label: 'Steps (from HONOR Health)',
          value: _steps,
          leadingIcon: Icons.directions_walk,
          options: [for (final s in _stepPresets) PickerOption(value: s, label: '$s steps', icon: Icons.directions_walk)],
          onChanged: (v) => setState(() => _steps = v),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save_outlined, size: 18),
            onPressed: () {
              ref.read(dailyStateActionsProvider).setQuickLog(widget.todayKey, sleepHours: _sleep, weightKg: _weight, steps: _steps);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved today's numbers"), duration: Duration(seconds: 1)));
            },
            label: const Text("Save today's numbers"),
          ),
        ),
      ],
    );
  }
}

class _WeightStepper extends StatelessWidget {
  final double? value;
  final ValueChanged<double> onChanged;
  const _WeightStepper({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final display = value?.toStringAsFixed(1) ?? '—';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(color: p.surfaceSunken, borderRadius: BorderRadius.circular(12), border: Border.all(color: p.border, width: 1.2)),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(Icons.monitor_weight_outlined, size: 18, color: p.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weight (kg)', style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
                Text(display, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: p.textPrimary)),
              ],
            ),
          ),
          _StepBtn(icon: Icons.remove, onTap: () => onChanged(((value ?? 70) - 0.1).clamp(30, 250))),
          _StepBtn(icon: Icons.add, onTap: () => onChanged(((value ?? 70) + 0.1).clamp(30, 250))),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 16, color: p.primary),
      ),
    );
  }
}
