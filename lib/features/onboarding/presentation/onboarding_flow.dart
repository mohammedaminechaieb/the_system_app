import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/onboarding_providers.dart';

/// First-run welcome flow: philosophy → theme pick → season pick → ready.
/// Deliberately short (4 screens, skippable feel via fast swiping) since
/// the goal is orientation, not a wall to get through.
class OnboardingFlow extends ConsumerStatefulWidget {
  final VoidCallback onFinished;
  const OnboardingFlow({super.key, required this.onFinished});

  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  final _controller = PageController();
  int _page = 0;
  static const _totalPages = 4;

  void _next() {
    HapticFeedback.selectionClick();
    if (_page == _totalPages - 1) {
      _finish();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOutCubic);
    }
  }

  Future<void> _finish() async {
    await ref.read(onboardingActionsProvider).markSeen();
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Scaffold(
      backgroundColor: p.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
              child: Row(
                children: [
                  for (int i = 0; i < _totalPages; i++)
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        height: 4,
                        decoration: BoxDecoration(color: i <= _page ? p.primary : p.borderSoft, borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                  if (_page < _totalPages - 1)
                    TextButton(onPressed: _finish, child: Text('Skip', style: TextStyle(color: p.textFaint, fontSize: 12.5))),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: const [
                  _WelcomePage(),
                  _ThemePickPage(),
                  _SeasonPickPage(),
                  _ReadyPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(_page == _totalPages - 1 ? "Let's go" : 'Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.bar_chart_rounded, size: 34, color: p.primary),
          ),
          const SizedBox(height: 28),
          Text('Welcome to\nThe System', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32)),
          const SizedBox(height: 14),
          Text(
            'A lifestyle system built on one idea: consistency beats intensity. Small, repeatable habits — tracked honestly, adjusted for real life — beat a perfect plan you abandon in two weeks.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.textSecondary),
          ),
          const SizedBox(height: 18),
          Wrap(spacing: 8, runSpacing: 8, children: const [
            Pill(text: 'Habits', icon: Icons.check_circle_outline),
            Pill(text: 'Training', icon: Icons.fitness_center),
            Pill(text: 'Nutrition', icon: Icons.restaurant_outlined),
            Pill(text: 'Martial Arts', icon: Icons.sports_martial_arts),
          ]),
        ],
      ),
    );
  }
}

class _ThemePickPage extends ConsumerWidget {
  const _ThemePickPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final currentId = ref.watch(themeControllerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Make it yours', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text('Pick a look — you can change this anytime in Settings.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.textSecondary)),
          const SizedBox(height: 22),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: [
              for (final id in AppThemeId.values)
                _OnboardingThemeSwatch(id: id, selected: id == currentId, onTap: () => ref.read(themeControllerProvider.notifier).setTheme(id)),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnboardingThemeSwatch extends StatelessWidget {
  final AppThemeId id;
  final bool selected;
  final VoidCallback onTap;
  const _OnboardingThemeSwatch({required this.id, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.forId(id);
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: palette.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? palette.primary : Colors.black12, width: selected ? 2.5 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(width: 14, height: 14, decoration: BoxDecoration(color: palette.primary, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Container(width: 14, height: 14, decoration: BoxDecoration(color: palette.accent, shape: BoxShape.circle)),
              const Spacer(),
              if (selected) Icon(Icons.check_circle, size: 16, color: palette.primary),
            ]),
            const Spacer(),
            Text(id.label, style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700, fontSize: 13.5)),
          ],
        ),
      ),
    );
  }
}

class _SeasonPickPage extends ConsumerWidget {
  const _SeasonPickPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final season = ref.watch(seasonProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('What season is it?', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text('This changes your cardio guidance, calendar, and nutrition notes. Switch anytime.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.textSecondary)),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(child: _SeasonCard(label: 'Summer', icon: Icons.wb_sunny_rounded, selected: season == Season.summer, onTap: () => ref.read(seasonProvider.notifier).state = Season.summer)),
              const SizedBox(width: 12),
              Expanded(child: _SeasonCard(label: 'Winter', icon: Icons.ac_unit_rounded, selected: season == Season.winter, onTap: () => ref.read(seasonProvider.notifier).state = Season.winter)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _SeasonCard({required this.label, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: selected ? p.primarySoft : p.surfaceRaised,
          border: Border.all(color: selected ? p.primary : p.borderSoft, width: selected ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: selected ? p.primary : p.textFaint),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(fontWeight: FontWeight.w700, color: selected ? p.primary : p.textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _ReadyPage extends StatelessWidget {
  const _ReadyPage();

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: p.accentSoft, borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.rocket_launch_rounded, size: 32, color: p.accent),
          ),
          const SizedBox(height: 28),
          Text('One rule to remember', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 14),
          Text(
            'Never miss twice. A single missed day costs almost nothing — the system even has a built-in streak freeze for exactly that. Missing two in a row is what breaks momentum, so that\'s the only thing worth actually protecting against.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: p.textSecondary),
          ),
          const SizedBox(height: 18),
          const CalloutBox(icon: Icons.favorite_border, text: "Every morning starts with a 10-second check-in. That's it — the rest of the app is there when you want it."),
        ],
      ),
    );
  }
}
