import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/visual_widgets.dart';
import '../domain/martial_arts_data.dart';

Future<void> openExternalUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class MartialArtDetailScreen extends StatelessWidget {
  final MartialArt art;
  const MartialArtDetailScreen({super.key, required this.art});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: p.bg,
            flexibleSpace: FlexibleSpaceBar(
              background: HeroHeader(imageUrl: art.imageUrl, fallbackIcon: Icons.sports_martial_arts, title: art.name, subtitle: 'Martial art profile'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(child: MetricTile(icon: Icons.favorite, value: '${art.cardio}/10', label: 'CARDIO')),
                    const SizedBox(width: 8),
                    Expanded(child: MetricTile(icon: Icons.fitness_center, value: '${art.strength}/10', label: 'STRENGTH')),
                    const SizedBox(width: 8),
                    Expanded(child: MetricTile(icon: Icons.shield, value: '${art.selfDefense}/10', label: 'SELF-DEF')),
                    const SizedBox(width: 8),
                    Expanded(child: MetricTile(icon: Icons.warning_amber, value: '${art.injuryRisk}/10', label: 'RISK')),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                SectionCard(
                  title: 'Our take',
                  titleIcon: Icons.lightbulb_outline,
                  child: Text(art.recommendation, style: Theme.of(context).textTheme.bodyLarge),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (art.techniques.isNotEmpty) ...[
                  Text('Technique primers', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  for (final t in art.techniques) Accordion(title: t.title, icon: Icons.sports_martial_arts, child: Text(t.body, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6))),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (art.resources.isNotEmpty) ...[
                  Text('Free, legal resources', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  for (final r in art.resources)
                    ThumbnailRow(
                      title: r.title,
                      subtitle: r.source,
                      imageUrl: art.imageUrl,
                      fallbackIcon: Icons.menu_book,
                      onTap: () => openExternalUrl(r.url),
                      trailing: const Icon(Icons.open_in_new, size: 16),
                    ),
                ],
                const SizedBox(height: AppSpacing.md),
                const CalloutBox(icon: Icons.school_outlined, text: 'Prioritize finding a real local class over reading — resources here are for context between sessions, not a substitute for a coach.'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
