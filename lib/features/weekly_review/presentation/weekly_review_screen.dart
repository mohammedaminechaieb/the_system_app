import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ai/gemini_service.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/weekly_review_providers.dart';

/// A weekly (not daily) AI reflection — deliberately not part of the daily
/// gate, so it never turns into a chore. Cached per week; only re-calls
/// the API when the person explicitly asks for a refresh.
class WeeklyReviewScreen extends ConsumerStatefulWidget {
  const WeeklyReviewScreen({super.key});

  @override
  ConsumerState<WeeklyReviewScreen> createState() => _WeeklyReviewScreenState();
}

class _WeeklyReviewScreenState extends ConsumerState<WeeklyReviewScreen> {
  bool _generating = false;
  String? _error;

  Future<void> _generate() async {
    setState(() {
      _generating = true;
      _error = null;
    });
    final result = await ref.read(weeklyReviewActionsProvider).generate();
    if (!mounted) return;
    setState(() {
      _generating = false;
      if (result == null) {
        _error = GeminiService.instance.isConfigured
            ? "Couldn't reach the AI right now — check your connection and try again."
            : 'Add a Gemini API key in your .env file to use the weekly review.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final cachedAsync = ref.watch(cachedWeeklyReviewProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly review')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const CalloutBox(icon: Icons.calendar_view_week_outlined, text: 'Covers the last 7 days. Generated only when you ask — never automatically.'),
          const SizedBox(height: AppSpacing.lg),
          cachedAsync.when(
            data: (cached) {
              if (cached == null && !_generating) {
                return SectionCard(
                  title: 'This week',
                  titleIcon: Icons.auto_awesome_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No review generated yet for this week.', style: TextStyle(color: p.textSecondary)),
                      const SizedBox(height: 14),
                      if (_error != null) ...[
                        Text(_error!, style: TextStyle(color: p.danger, fontSize: 12.5)),
                        const SizedBox(height: 10),
                      ],
                      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _generate, child: const Text('Generate review'))),
                    ],
                  ),
                );
              }
              return SectionCard(
                title: 'This week',
                titleIcon: Icons.auto_awesome_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_generating)
                      const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Center(child: CircularProgressIndicator()))
                    else ...[
                      Text(cached!.content, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
                      const SizedBox(height: 6),
                      Text('Generated ${_relativeTime(cached.generatedAt)}', style: TextStyle(fontSize: 11, color: p.textFaint)),
                      const SizedBox(height: 14),
                      if (_error != null) ...[
                        Text(_error!, style: TextStyle(color: p.danger, fontSize: 12.5)),
                        const SizedBox(height: 10),
                      ],
                      OutlinedButton.icon(onPressed: _generate, icon: const Icon(Icons.refresh, size: 16), label: const Text('Refresh')),
                    ],
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('$e'),
          ),
        ],
      ),
    );
  }
}

String _relativeTime(DateTime t) {
  final diff = DateTime.now().difference(t);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes}m ago';
  if (diff.inDays < 1) return '${diff.inHours}h ago';
  return '${diff.inDays}d ago';
}
