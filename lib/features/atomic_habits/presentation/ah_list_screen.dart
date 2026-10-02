import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/widgets/visual_widgets.dart';
import '../data/ah_providers.dart';
import '../domain/ah_content.dart';
import 'ah_reader_screen.dart';
import '../../../core/widgets/fade_slide_route.dart';

const _kHeroImg = 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=1200&q=80';

class AtomicHabitsListScreen extends ConsumerWidget {
  const AtomicHabitsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(readingProgressProvider);
    final chapters = AtomicHabitsContent.chapters;
    final p = AppPalette.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: p.bg,
            flexibleSpace: const FlexibleSpaceBar(
              background: HeroHeader(imageUrl: _kHeroImg, fallbackIcon: Icons.menu_book, title: 'Atomic Habits', subtitle: 'A full 10-chapter resume, not a summary'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
            sliver: progressAsync.when(
              data: (progress) {
                final completedCount = chapters.where((c) => progress[c.id]?.completed == true).length;
                return SliverList(
                  delegate: SliverChildListDelegate([
                    SectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Original wording throughout — not reproduced text from the book. Tap a chapter to read it as a paginated essay.",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(value: completedCount / chapters.length, minHeight: 7),
                          ),
                          const SizedBox(height: 6),
                          Text('$completedCount / ${chapters.length} chapters completed', style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 11, color: p.textFaint)),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    for (final chapter in chapters)
                      _ChapterTile(
                        number: chapter.number,
                        title: chapter.title,
                        subtitle: chapter.subtitle,
                        readTime: chapter.readTime,
                        completed: progress[chapter.id]?.completed ?? false,
                        onTap: () => Navigator.of(context).pushPolished(AtomicHabitsReaderScreen(chapter: chapter)),
                      ),
                  ]),
                );
              },
              loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (e, _) => SliverToBoxAdapter(child: Center(child: Text('$e'))),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChapterTile extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final String readTime;
  final bool completed;
  final VoidCallback onTap;

  const _ChapterTile({required this.number, required this.title, required this.subtitle, required this.readTime, required this.completed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(p.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: completed ? p.primary : p.primarySoft, shape: BoxShape.circle),
                child: completed
                    ? Icon(Icons.check, color: p.primaryOn, size: 20)
                    : Text('$number', style: TextStyle(fontFamily: p.monoFontFamily, fontWeight: FontWeight.w700, color: p.primary)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 4),
                    Text(readTime, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 10.5, color: p.textFaint)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: p.textFaint),
            ],
          ),
        ),
      ),
    );
  }
}
