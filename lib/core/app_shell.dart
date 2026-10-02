import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/atomic_habits/presentation/ah_list_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/gate/presentation/gate_screen.dart';
import '../features/nutrition/presentation/nutrition_screen.dart';
import '../features/onboarding/data/onboarding_providers.dart';
import '../features/onboarding/presentation/onboarding_flow.dart';
import '../features/reference/presentation/reference_screen.dart';
import '../features/screentime/presentation/screen_time_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/sports/presentation/sports_screen.dart';
import '../features/today/presentation/today_screen.dart';
import '../features/track/presentation/track_screen.dart';
import '../features/weekly_review/presentation/weekly_review_screen.dart';
import 'providers/streak_engine.dart';
import 'theme/app_palette.dart';
import 'widgets/shared_widgets.dart';
import 'widgets/fade_slide_route.dart';

/// Root shell: first-run [OnboardingFlow] → soft-lock [GateScreen] (until
/// today's gate is passed) → the bottom-nav app. The gate can always be
/// re-opened voluntarily via the home tab if the person wants to revisit
/// their check-in, but it is never forced open again once unlocked for
/// the day (that would defeat the "soft" in soft lock).
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});
  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  bool _unlockedForSession = false;
  bool _onboardingJustFinished = false;

  @override
  Widget build(BuildContext context) {
    final launchEval = ref.watch(appLaunchEvaluatorProvider);
    final onboardingSeenAsync = ref.watch(onboardingSeenProvider);
    final p = AppPalette.of(context);

    return launchEval.when(
      data: (_) {
        return onboardingSeenAsync.when(
          data: (seen) {
            if (!seen && !_onboardingJustFinished) {
              return OnboardingFlow(onFinished: () => setState(() => _onboardingJustFinished = true));
            }
            if (!_unlockedForSession) {
              return GateScreen(onUnlocked: () => setState(() => _unlockedForSession = true));
            }
            return const _MainNavigation();
          },
          loading: () => Scaffold(backgroundColor: p.bg, body: Center(child: CircularProgressIndicator(color: p.primary))),
          error: (e, _) => Scaffold(body: Center(child: Text('Startup error: $e'))),
        );
      },
      loading: () => Scaffold(backgroundColor: p.bg, body: Center(child: CircularProgressIndicator(color: p.primary))),
      error: (e, _) => Scaffold(body: Center(child: Text('Startup error: $e'))),
    );
  }
}

class _MainNavigation extends ConsumerStatefulWidget {
  const _MainNavigation();
  @override
  ConsumerState<_MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<_MainNavigation> {
  int _index = 0;

  static const _screens = [
    TodayScreen(),
    TrackScreen(),
    CalendarScreen(),
    DashboardScreen(),
    _MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.wb_sunny_outlined), selectedIcon: Icon(Icons.wb_sunny), label: 'Today'),
          NavigationDestination(icon: Icon(Icons.checklist_outlined), selectedIcon: Icon(Icons.checklist), label: 'Track'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.more_horiz), selectedIcon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

/// "More" tab: a small hub linking to the less frequently visited but
/// still substantial sections — Atomic Habits, Nutrition, Sports &
/// Activities, Reference, and Settings — so the bottom nav doesn't need
/// six-plus destinations.
class _MoreScreen extends StatelessWidget {
  const _MoreScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _MoreTile(
            icon: Icons.menu_book,
            title: 'Atomic Habits',
            subtitle: '10-chapter full resume',
            onTap: () => Navigator.of(context).pushPolished(const AtomicHabitsListScreen()),
          ),
          _MoreTile(
            icon: Icons.restaurant,
            title: 'Nutrition',
            subtitle: 'Food, diet, fat loss science',
            onTap: () => Navigator.of(context).pushPolished(const NutritionScreen()),
          ),
          _MoreTile(
            icon: Icons.sports_martial_arts,
            title: 'Sports & Activities',
            subtitle: 'Strength, cardio, season-aware',
            onTap: () => Navigator.of(context).pushPolished(const SportsScreen()),
          ),
          _MoreTile(
            icon: Icons.auto_stories,
            title: 'Reference',
            subtitle: 'Martial arts, hobbies, getting started',
            onTap: () => Navigator.of(context).pushPolished(const ReferenceScreen()),
          ),
          _MoreTile(
            icon: Icons.auto_awesome,
            title: 'Weekly AI review',
            subtitle: 'A specific, data-grounded coaching note — once a week',
            onTap: () => Navigator.of(context).pushPolished(const WeeklyReviewScreen()),
          ),
          _MoreTile(
            icon: Icons.hourglass_bottom,
            title: 'Screen time',
            subtitle: 'Earn back blocked apps by logging activity',
            onTap: () => Navigator.of(context).pushPolished(const ScreenTimeScreen()),
          ),
          _MoreTile(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'Theme, season, streak system, about',
            onTap: () => Navigator.of(context).pushPolished(const SettingsScreen()),
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _MoreTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: p.primary, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: Icon(Icons.chevron_right, color: p.textFaint),
      ),
    );
  }
}
