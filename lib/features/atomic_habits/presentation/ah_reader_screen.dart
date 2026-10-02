import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/ah_providers.dart';
import '../domain/ah_models.dart';

class AtomicHabitsReaderScreen extends ConsumerStatefulWidget {
  final AhChapter chapter;
  const AtomicHabitsReaderScreen({super.key, required this.chapter});

  @override
  ConsumerState<AtomicHabitsReaderScreen> createState() => _AtomicHabitsReaderScreenState();
}

class _AtomicHabitsReaderScreenState extends ConsumerState<AtomicHabitsReaderScreen> {
  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final sections = widget.chapter.sections;
    final total = sections.length;

    return Scaffold(
      backgroundColor: p.bg,
      appBar: AppBar(
        title: Text('Chapter ${widget.chapter.number}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: (_page + 1) / total, backgroundColor: p.borderSoft, color: p.primary, minHeight: 4),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: total,
              onPageChanged: (i) {
                setState(() => _page = i);
                ref.read(readingActionsProvider).saveLastPage(widget.chapter.id, i);
              },
              itemBuilder: (context, index) => _SectionPage(chapterTitle: widget.chapter.title, pageNumber: index + 1, totalPages: total, section: sections[index]),
            ),
          ),
          _ReaderControls(
            page: _page,
            total: total,
            onPrev: () => _controller.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut),
            onNext: () {
              if (_page == total - 1) {
                ref.read(readingActionsProvider).markCompleted(widget.chapter.id);
                Navigator.of(context).pop();
              } else {
                _controller.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SectionPage extends StatelessWidget {
  final String chapterTitle;
  final int pageNumber;
  final int totalPages;
  final AhSection section;

  const _SectionPage({required this.chapterTitle, required this.pageNumber, required this.totalPages, required this.section});

  List<String> _paragraphs(String text) => text.split('\n\n');

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$chapterTitle · page $pageNumber of $totalPages', style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 11, color: p.textFaint, letterSpacing: 0.3)),
          const SizedBox(height: 14),
          if (section.heading != null) ...[
            Text(section.heading!, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 14),
          ],
          if (section.calloutLabel != null) ...[
            Pill(text: section.calloutLabel!.toUpperCase(), background: p.accentSoft, foreground: p.accent),
            const SizedBox(height: 14),
          ],
          if (section.body.isNotEmpty)
            ..._paragraphs(section.body).map((para) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Text(para, style: TextStyle(fontSize: 15.5, height: 1.6, color: p.textPrimary)))),
          if (section.bullets != null) ...[const SizedBox(height: 4), BulletList(items: section.bullets!, gap: 12)],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _ReaderControls extends StatelessWidget {
  final int page;
  final int total;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  const _ReaderControls({required this.page, required this.total, required this.onPrev, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(color: p.surface, border: Border(top: BorderSide(color: p.borderSoft))),
      child: Row(
        children: [
          if (page > 0) Expanded(child: OutlinedButton(onPressed: onPrev, child: const Text('← Back'))),
          if (page > 0) const SizedBox(width: 12),
          Expanded(flex: 2, child: ElevatedButton(onPressed: onNext, child: Text(page == total - 1 ? 'Finish chapter ✓' : 'Continue →'))),
        ],
      ),
    );
  }
}
