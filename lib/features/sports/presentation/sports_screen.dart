import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/visual_widgets.dart';

const _kHeroImg = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=1200&q=80';

class SportsScreen extends ConsumerWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);
    final isSummer = season == Season.summer;
    final p = AppPalette.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            backgroundColor: p.bg,
            flexibleSpace: const FlexibleSpaceBar(
              background: HeroHeader(imageUrl: _kHeroImg, fallbackIcon: Icons.sports_gymnastics, title: 'Sports & Activities', subtitle: 'Season-aware programming'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Pill(icon: isSummer ? Icons.wb_sunny_rounded : Icons.ac_unit_rounded, text: isSummer ? 'Summer mode active' : 'Winter mode active'),
                const SizedBox(height: AppSpacing.lg),

                Text('Home strength — no equipment', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const HorizontalCardScroll(
                  height: 150,
                  children: [
                    _ExerciseCard(name: 'Legs', prog: 'Squat → split squat → Bulgarian split squat', img: 'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?w=500&q=80'),
                    _ExerciseCard(name: 'Chest', prog: 'Knee push-up → push-up → decline', img: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=500&q=80'),
                    _ExerciseCard(name: 'Back', prog: 'Towel rows → doorframe → inverted rows', img: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500&q=80'),
                    _ExerciseCard(name: 'Core', prog: 'Dead bug → plank → hollow hold', img: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=500&q=80'),
                  ],
                ),
                const SizedBox(height: 12),
                const SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('3 sets of 8–15 reps, 60–90s rest. Increase difficulty once all sets hit the top of the range with good form.', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 8, children: [
                        Pill(text: '20 min — low energy'),
                        Pill(text: '30 min — default'),
                        Pill(text: '45 min — high energy'),
                        Pill(text: '5–10 min — always doable'),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Text(isSummer ? 'Summer cardio plan' : 'Winter cardio plan', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                if (isSummer)
                  const Column(children: [
                    CalloutBox.summer(text: 'Running outdoors in real heat adds strain without burning meaningfully more fat.'),
                    SizedBox(height: 10),
                    BulletList(items: [
                      'Move hard cardio before 8am, or fully indoors',
                      'Swap running for swimming or indoor cycling',
                      'Walking still works if paced easily — avoid 12:00–17:00',
                      'Jump rope indoors is a heat-proof substitute for a run',
                    ]),
                  ])
                else
                  const Column(children: [
                    CalloutBox.winter(text: 'Your commute is a built-in cardio opportunity.'),
                    SizedBox(height: 10),
                    BulletList(items: [
                      'Walk part of your 1h commute each way',
                      'Outdoor running is fine with a proper warm-up',
                      'Indoor cardio on icy/very cold days',
                      'Anchor cardio to a fixed time, not daylight',
                    ]),
                  ]),
                const SizedBox(height: AppSpacing.lg),

                Text('Sports comparison', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  children: const [
                    _SportCard(name: 'Walking', fatigue: 'Low', icon: Icons.directions_walk),
                    _SportCard(name: 'Cycling', fatigue: 'Low–Mod', icon: Icons.directions_bike),
                    _SportCard(name: 'Swimming', fatigue: 'Moderate', icon: Icons.pool),
                    _SportCard(name: 'Jump rope', fatigue: 'Mod–High', icon: Icons.sports),
                    _SportCard(name: 'Running', fatigue: 'Mod–High', icon: Icons.directions_run),
                    _SportCard(name: 'Team sports', fatigue: 'High', icon: Icons.sports_basketball),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                const SectionCard(
                  title: 'Should I train today?',
                  titleIcon: Icons.help_outline,
                  child: BulletList(items: [
                    'Injured or sharp pain? → No, rest.',
                    'Sick with fever? → No, rest until recovered.',
                    '2+ weeks declining performance? → Deload, reduce volume ~40–50%.',
                    'Just tired/unmotivated? → Yes, scale to low-energy routine.',
                    'None of the above? → Train as planned.',
                  ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final String name, prog, img;
  const _ExerciseCard({required this.name, required this.prog, required this.img});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 150, child: VisualCard(title: name, subtitle: prog, imageUrl: img, fallbackIcon: Icons.fitness_center, onTap: () {}));
  }
}

class _SportCard extends StatelessWidget {
  final String name, fatigue;
  final IconData icon;
  const _SportCard({required this.name, required this.fatigue, required this.icon});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: p.surfaceRaised, border: Border.all(color: p.borderSoft), borderRadius: BorderRadius.circular(p.cardRadius * 0.7)),
      child: Row(
        children: [
          Icon(icon, color: p.primary, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                Text(fatigue, style: TextStyle(fontSize: 11, color: p.textFaint)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
