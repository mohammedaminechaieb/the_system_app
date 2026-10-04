import 'package:flutter/material.dart';

import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/visual_widgets.dart';

const _kHeroImg = 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=1200&q=80';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            backgroundColor: AppPalette.of(context).bg,
            flexibleSpace: const FlexibleSpaceBar(
              background: HeroHeader(imageUrl: _kHeroImg, fallbackIcon: Icons.restaurant, title: 'Food & Diet', subtitle: 'Sustainable, not extreme'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const CalloutBox(
                  icon: Icons.check_circle_outline,
                  text: 'No foods are banned. Roughly 80–90% of meals support your goals; the rest is flexible eating.',
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('The basics', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.3,
                  children: const [
                    _NutrientCard(icon: Icons.egg_outlined, name: 'Protein', tip: 'A source at most meals'),
                    _NutrientCard(icon: Icons.grain, name: 'Carbs', tip: 'Whole grains, fruit, potatoes'),
                    _NutrientCard(icon: Icons.opacity, name: 'Fats', tip: 'Olive oil, nuts, fish'),
                    _NutrientCard(icon: Icons.eco_outlined, name: 'Fiber', tip: 'Veg, fruit, legumes'),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                const SectionCard(
                  title: 'Fat loss — what actually works',
                  titleIcon: Icons.trending_down,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EvidencePill.wellSupported(),
                      SizedBox(height: 10),
                      Text('A sustained deficit of ~500–1,000 kcal/day, targeting no more than ~0.5–0.9 kg/week loss.'),
                      SizedBox(height: 12),
                      CalloutBox(icon: Icons.water_drop_outlined, text: 'Sweating ≠ fat loss. Sweat is heat regulation — scale drops from heat exposure are water, not fat.'),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('"Fat-loss machines" — what they actually do', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const SectionCard(
                  child: Column(
                    children: [
                      _DeviceRow(name: 'Sauna / heat belts', well: false),
                      _DeviceRow(name: 'Vibration plates', well: false),
                      _DeviceRow(name: 'EMS belts', well: false),
                      _DeviceRow(name: 'Cardio machines', well: true),
                      _DeviceRow(name: 'Walking pads', well: true, isLast: true),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('Low-effort meal ideas', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const HorizontalCardScroll(
                  height: 150,
                  children: [
                    _MealCard(name: 'Fast breakfast', desc: 'Yogurt + oats + fruit', img: 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?w=500&q=80'),
                    _MealCard(name: 'Fast lunch', desc: 'Rice + beans/chicken + veg', img: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=500&q=80'),
                    _MealCard(name: 'Fast dinner', desc: 'One-pan stir fry', img: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&q=80'),
                    _MealCard(name: 'Protein snack', desc: 'Cottage cheese, eggs, tuna', img: 'https://images.unsplash.com/photo-1488477304112-4944851de03d?w=500&q=80'),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('Summer vs. winter eating', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                const CalloutBox.summer(text: 'Hydration needs rise with heat. Appetite often drops — don\'t force large meals; favor water-rich foods.'),
                const SizedBox(height: 10),
                const CalloutBox.winter(text: 'Comfort-food cravings are normal. Keep protein consistent — warm, filling meals support the same pattern.'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String tip;
  const _NutrientCard({required this.icon, required this.name, required this.tip});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: p.surfaceRaised, border: Border.all(color: p.borderSoft), borderRadius: BorderRadius.circular(p.cardRadius * 0.7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: p.primary, size: 22),
          const Spacer(),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 2),
          Text(tip, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2),
        ],
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  final String name;
  final bool well;
  final bool isLast;
  const _DeviceRow({required this.name, required this.well, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: isLast ? null : Border(bottom: BorderSide(color: p.borderSoft))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(name, style: const TextStyle(fontSize: 13.5)), well ? const EvidencePill.wellSupported() : const EvidencePill.weak()]),
    );
  }
}

class _MealCard extends StatelessWidget {
  final String name;
  final String desc;
  final String img;
  const _MealCard({required this.name, required this.desc, required this.img});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: VisualCard(title: name, subtitle: desc, imageUrl: img, fallbackIcon: Icons.restaurant, onTap: () {}),
    );
  }
}
