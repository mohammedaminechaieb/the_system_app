import 'package:flutter/material.dart';

import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/visual_widgets.dart';
import '../domain/hobbies_data.dart';
import '../domain/martial_arts_data.dart';
import 'martial_art_detail_screen.dart';
import '../../../core/widgets/fade_slide_route.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reference'),
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'Martial Arts'),
            Tab(text: 'Hobbies'),
            Tab(text: 'Getting Started'),
            Tab(text: 'Priorities'),
          ]),
        ),
        body: const TabBarView(children: [_MartialArtsGrid(), _HobbiesTab(), _GettingStartedTab(), _PrioritiesTab()]),
      ),
    );
  }
}

class _MartialArtsGrid extends StatelessWidget {
  const _MartialArtsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.78),
      itemCount: MartialArtsData.arts.length,
      itemBuilder: (context, i) {
        final art = MartialArtsData.arts[i];
        return VisualCard(
          title: art.name,
          subtitle: 'Self-def ${art.selfDefense}/10 · risk ${art.injuryRisk}/10',
          imageUrl: art.imageUrl,
          fallbackIcon: Icons.sports_martial_arts,
          onTap: () => Navigator.of(context).pushPolished(MartialArtDetailScreen(art: art)),
        );
      },
    );
  }
}

class _HobbiesTab extends StatelessWidget {
  const _HobbiesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, AppSpacing.lg, 0, 40),
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg), child: Text('Pick one per category — a focused rotating set beats a scattered abandoned one.')),
        const SizedBox(height: 14),
        HorizontalCardScroll(
          height: 190,
          children: [
            for (final c in HobbiesData.categories)
              SizedBox(
                width: 150,
                child: VisualCard(
                  title: c.category,
                  subtitle: c.examples.join(' · '),
                  imageUrl: c.imageUrl,
                  fallbackIcon: c.icon,
                  onTap: () => _showCategorySheet(context, c),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: SectionCard(
            title: 'Best return on time invested',
            titleIcon: Icons.trending_up,
            child: Column(
              children: [
                for (final b in HobbiesData.bestReturn)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(b.$3, size: 20, color: AppPalette.of(context).primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(b.$1, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                              Text(b.$2, style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCategorySheet(BuildContext context, HobbyCategoryInfo c) {
    final p = AppPalette.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(p.cardRadius))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.category, style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: [for (final e in c.examples) Pill(text: e, icon: c.icon)]),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}

class _GettingStartedTab extends StatelessWidget {
  const _GettingStartedTab();

  static const _days = [
    ('1', 'Fixed wake time. 20-min strength routine or a walk. That\'s it.'),
    ('2', 'Same wake time. 5-min meditation. Strength or walk again.'),
    ('3', 'Same wake time. Try 5-min Tai Chi instead of/alongside meditation.'),
    ('4', 'Same wake time. Repeat. Start checking off habits daily.'),
    ('5', 'Look up 1–2 martial arts trial classes near you.'),
    ('6', 'Rest or light day — walk, Tai Chi, nothing else required.'),
    ('7', 'Weekly review in Dashboard. Sketch next week.'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        SectionCard(
          title: 'Your first 7 days',
          titleIcon: Icons.flag_outlined,
          child: Column(
            children: [
              for (final d in _days)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: p.primarySoft, shape: BoxShape.circle),
                        child: Text(d.$1, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 12, fontWeight: FontWeight.w700, color: p.primary)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Padding(padding: const EdgeInsets.only(top: 3), child: Text(d.$2, style: Theme.of(context).textTheme.bodyLarge))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionCard(
          title: 'Starting a martial art',
          titleIcon: Icons.sports_martial_arts,
          child: const BulletList(items: [
            'Pick 2–3 candidates from the grid based on what you\'re optimizing for',
            'Search "[art] intro class near me" — most gyms offer a free/cheap trial',
            'Attend one trial per art over 2–3 weeks — judge the coach and people as much as the art',
            'Commit to one for 8+ weeks before reassessing',
          ]),
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionCard(
          title: 'Starting a new hobby',
          titleIcon: Icons.star_outline,
          child: const BulletList(items: [
            'Pick exactly one per category — resist starting three at once',
            'Two-minute rule: day one is just opening the material for 2 minutes',
            'Habit-stack it right after an existing habit',
            'Give it 3–4 weeks before judging whether you enjoy it',
          ]),
        ),
      ],
    );
  }
}

class _PrioritiesTab extends StatelessWidget {
  const _PrioritiesTab();

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        SectionCard(
          title: 'What matters most',
          titleIcon: Icons.check_circle_outline,
          child: Wrap(spacing: 8, runSpacing: 8, children: const [
            Pill(text: 'Sleep 7–9h, consistent wake'),
            Pill(text: 'Move almost every day'),
            Pill(text: 'Strength ~3x/week'),
            Pill(text: '150–250 min/week cardio'),
            Pill(text: 'Whole foods, enough protein'),
            Pill(text: 'One recovery day/week'),
            Pill(text: 'Track 3–5 things max'),
            Pill(text: 'Learn/read most days'),
            Pill(text: 'One social anchor/week'),
            Pill(text: 'Smaller version > skipping'),
          ]),
        ),
        const SizedBox(height: AppSpacing.lg),
        SectionCard(
          title: "What's not worth the worry",
          titleIcon: Icons.self_improvement,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final t in const [
                'Exact training time', 'Perfect calorie accuracy', 'One missed workout', 'Heavy sweating',
                '"Optimal" exercises', 'One imperfect meal', '7 vs 10 min meditation', 'Comparing to others',
                'Every category daily', 'Bedtime off by 20 min',
              ])
                Pill(text: t, background: p.dangerSoft, foreground: p.danger),
            ],
          ),
        ),
      ],
    );
  }
}
