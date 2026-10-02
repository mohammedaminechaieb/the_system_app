import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/providers/streak_engine.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/fade_slide_route.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../habits/presentation/manage_habits_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final season = ref.watch(seasonProvider);
    final currentThemeId = ref.watch(themeControllerProvider);
    final streakAsync = ref.watch(streakStateStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
        children: [
          SectionCard(
            title: 'Appearance',
            titleIcon: Icons.palette_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pick a look — recolors the whole app instantly.'),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: [
                    for (final id in AppThemeId.values)
                      _ThemeSwatch(id: id, selected: id == currentThemeId, onTap: () => ref.read(themeControllerProvider.notifier).setTheme(id)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'Season',
            titleIcon: Icons.calendar_view_month,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Switches the calendar, cardio guidance, and nutrition notes between winter (full commute) and summer (hybrid/remote) modes.'),
                const SizedBox(height: 14),
                SegmentedButton<Season>(
                  segments: const [
                    ButtonSegment(value: Season.summer, label: Text('Summer'), icon: Icon(Icons.wb_sunny_rounded)),
                    ButtonSegment(value: Season.winter, label: Text('Winter'), icon: Icon(Icons.ac_unit_rounded)),
                  ],
                  selected: {season},
                  onSelectionChanged: (s) => ref.read(seasonProvider.notifier).state = s.first,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'Habits',
            titleIcon: Icons.checklist_rtl,
            onTap: () => Navigator.of(context).pushPolished(const ManageHabitsScreen()),
            child: const Row(
              children: [
                Expanded(child: Text('Add habits, set difficulty tiers, and choose which ones are required for the daily gate.')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'Streak & penalty system',
            titleIcon: Icons.local_fire_department_outlined,
            child: streakAsync.when(
              data: (s) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(label: 'Current streak', value: '${s.currentStreak} days'),
                  _InfoRow(label: 'Longest streak', value: '${s.longestStreak} days'),
                  _InfoRow(label: 'Total points', value: '${s.totalPoints}'),
                  _InfoRow(label: 'Streak freezes available', value: '${s.freezesAvailable} / 2', isLast: true),
                  const SizedBox(height: 12),
                  Text(
                    'A freeze is earned back every 14-day streak (max 2 held). A fully missed day consumes a freeze automatically if available; otherwise your streak resets and a small point penalty applies.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              loading: () => const SizedBox(height: 40),
              error: (e, _) => Text('$e'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'Data & privacy',
            titleIcon: Icons.lock_outline,
            child: const Text('All data lives only in a local SQLite database on this device. Nothing is sent anywhere. Uninstalling the app deletes this data permanently.'),
          ),
          const SizedBox(height: AppSpacing.lg),

          SectionCard(
            title: 'About',
            titleIcon: Icons.info_outline,
            child: const Text('The System — a personal lifestyle, fitness, habits and time-management app.\n\nVersion 1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  final AppThemeId id;
  final bool selected;
  final VoidCallback onTap;
  const _ThemeSwatch({required this.id, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.forId(id);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: palette.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? palette.primary : Colors.black12, width: selected ? 2.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _dot(palette.primary),
                const SizedBox(width: 4),
                _dot(palette.accent),
                const SizedBox(width: 4),
                _dot(palette.surfaceRaised, border: true),
                const Spacer(),
                if (selected) Icon(Icons.check_circle, size: 16, color: palette.primary),
              ],
            ),
            const Spacer(),
            Text(id.label, style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700, fontSize: 13.5)),
            const SizedBox(height: 2),
            Text(id.description, style: TextStyle(color: palette.textSecondary, fontSize: 10.5), maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _dot(Color c, {bool border = false}) => Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: border ? Border.all(color: Colors.black12) : null),
      );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;
  const _InfoRow({required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(border: isLast ? null : Border(bottom: BorderSide(color: p.borderSoft))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 13, fontWeight: FontWeight.w700, color: p.primary)),
        ],
      ),
    );
  }
}
