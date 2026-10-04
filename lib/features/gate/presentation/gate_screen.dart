import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/animated_habit_check.dart';
import '../../../core/widgets/habit_icons.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../habits/data/habits_providers.dart';
import '../../today/data/today_providers.dart';
import '../../today/domain/plan_content.dart';

/// The soft-lock morning screen.
///
/// Design intent (rebuilt): this is a *nudge*, not a trap. Every element on
/// screen is always interactive — there is no disabled "unlock" button
/// waiting for a condition that might never resolve. Completing every core
/// habit reveals a clear "Continue" action; regardless of completion, a
/// plainly visible "Skip for now" is always tappable from the first frame.
/// The only consequence of skipping lives in the streak engine (a missed
/// day may cost a freeze or reset the streak) — never in the UI blocking
/// you from proceeding.
class GateScreen extends ConsumerWidget {
  final VoidCallback onUnlocked;
  const GateScreen({super.key, required this.onUnlocked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final todayKey = ref.watch(todayKeyProvider);
    final habitsAsync = ref.watch(todayHabitsProvider);
    final streakAsync = ref.watch(streakStateStreamProvider);
    final season = ref.watch(seasonProvider);
    final now = ref.watch(todayTickerProvider);
    final dayPlan = PlanContent.todayPlan(season, now);
    final dateLabel = DateFormat('EEEE, d MMMM').format(now);

    return Scaffold(
      backgroundColor: p.bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_greeting(now.hour), style: TextStyle(color: p.primary, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 1.4)),
                    const SizedBox(height: 6),
                    Text(dateLabel, style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 4),
                    Text('Quick check-in, then straight into your day.', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 18),

                    streakAsync.when(
                      data: (s) => Row(
                        children: [
                          _StatChip(icon: Icons.local_fire_department_rounded, label: '${s.currentStreak}d streak'),
                          const SizedBox(width: 8),
                          _StatChip(icon: Icons.ac_unit_rounded, label: '${s.freezesAvailable} freeze${s.freezesAvailable == 1 ? '' : 's'}'),
                          const SizedBox(width: 8),
                          _StatChip(icon: Icons.bolt_rounded, label: '${s.totalPoints} pts'),
                        ],
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),

                    SectionCard(
                      title: 'Energy today',
                      titleIcon: Icons.wb_sunny_outlined,
                      child: _EnergyRow(todayKey: todayKey),
                    ),
                    const SizedBox(height: 14),

                    SectionCard(
                      title: "Core habits",
                      titleIcon: Icons.check_circle_outline,
                      child: habitsAsync.when(
                        data: (habits) {
                          final core = habits.where((h) => h.habit.isCore).toList();
                          return Column(
                            children: [
                              if (core.isEmpty) Text('No core habits set — choose some in Settings → Habits.', style: TextStyle(color: p.textFaint, fontSize: 12.5)),
                              for (final h in core) _GateHabitTile(habitId: h.habit.id, label: h.habit.label, icon: h.habit.icon, done: h.done),
                            ],
                          );
                        },
                        loading: () => const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: CircularProgressIndicator())),
                        error: (e, _) => Text('$e'),
                      ),
                    ),
                    const SizedBox(height: 14),

                    SectionCard(
                      title: "Today's plan",
                      titleIcon: Icons.map_outlined,
                      padding: const EdgeInsets.all(16),
                      child: BulletList(items: dayPlan.items, gap: 6),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),

            // Bottom action bar — always interactive, no dead-end disabled state.
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
              decoration: BoxDecoration(
                color: p.surface,
                border: Border(top: BorderSide(color: p.borderSoft)),
              ),
              child: habitsAsync.when(
                data: (habits) {
                  final core = habits.where((h) => h.habit.isCore).toList();
                  final doneCount = core.where((h) => h.done).length;
                  final allDone = core.isNotEmpty && doneCount == core.length;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (allDone)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: onUnlocked,
                            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                            label: const Text("All set — continue"),
                          ),
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: onUnlocked,
                            child: Text('Skip for now  ·  $doneCount/${core.length} done'),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Text(
                        allDone
                            ? 'Nice — all core habits logged for today.'
                            : "Skipping won't stop tracking — an incomplete day may cost a streak freeze.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: p.textFaint, fontSize: 11),
                      ),
                    ],
                  );
                },
                loading: () => const SizedBox(height: 48),
                error: (_, __) => TextButton(onPressed: onUnlocked, child: const Text('Continue anyway')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: p.primary),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: p.primary, fontSize: 11.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _EnergyRow extends ConsumerWidget {
  final String todayKey;
  const _EnergyRow({required this.todayKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(todayStateProvider);
    final selected = stateAsync.valueOrNull?.energyLevel;

    return Row(
      children: [
        for (final plan in PlanContent.energyPlans)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: _EnergyOption(
                level: plan.level,
                label: plan.label,
                selected: selected == plan.level,
                onTap: () => ref.read(dailyStateActionsProvider).setEnergy(todayKey, plan.level),
              ),
            ),
          ),
      ],
    );
  }
}

class _EnergyOption extends StatelessWidget {
  final int level;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _EnergyOption({required this.level, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? p.primary : p.surfaceSunken,
          border: Border.all(color: selected ? p.primary : p.border, width: selected ? 2 : 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text('$level', style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: selected ? p.primaryOn : p.textPrimary)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 8.5, color: selected ? p.primaryOn.withValues(alpha: 0.85) : p.textFaint, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _GateHabitTile extends ConsumerWidget {
  final String habitId;
  final String label;
  final String icon;
  final bool done;
  const _GateHabitTile({required this.habitId, required this.label, required this.icon, required this.done});

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
            Icon(habitIcon(icon), size: 17, color: done ? p.primary : p.textFaint),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
          ],
        ),
      ),
    );
  }
}

String _greeting(int hour) {
  if (hour < 5) return 'LATE NIGHT CHECK-IN';
  if (hour < 12) return 'GOOD MORNING';
  if (hour < 18) return 'GOOD AFTERNOON';
  return 'GOOD EVENING';
}
