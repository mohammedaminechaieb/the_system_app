import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/quicklog_providers.dart';

/// Common subtypes offered per [QuickLogType] — kept short and specific so
/// the sheet stays picker-based rather than needing free text for the
/// common cases. "Other" always falls back to a short note instead.
const Map<QuickLogType, List<String>> _kSubtypeSuggestions = {
  QuickLogType.exercise: ['Running', 'Strength', 'Cycling', 'Swimming', 'Yoga', 'Walk', 'Other'],
  QuickLogType.meal: ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
  QuickLogType.hobby: ['Guitar', 'Reading', 'Gaming', 'Art', 'Cooking', 'Other'],
  QuickLogType.martialArts: ['Sparring', 'Technique drills', 'Conditioning', 'Grading/rank test'],
  QuickLogType.learning: ['Course', 'Book', 'Article', 'Practice project'],
};

const List<double> _kDurationPresets = [10, 15, 20, 30, 45, 60, 90];

/// Opens the quick-capture flow as a bottom sheet. Call this from anywhere
/// (currently the Today screen's FAB) to log any category in a few taps —
/// full picker-based detail screens for each domain remain available for
/// anyone who wants to go deeper than a quick log allows.
Future<void> showQuickCaptureSheet(BuildContext context, WidgetRef ref) async {
  final p = AppPalette.of(context);
  final suggested = await ref.read(quickLogActionsProvider).suggestLikelyType();
  if (!context.mounted) return;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: p.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(p.cardRadius))),
    builder: (sheetContext) => _QuickCaptureBody(initialType: suggested),
  );
}

class _QuickCaptureBody extends ConsumerStatefulWidget {
  final QuickLogType initialType;
  const _QuickCaptureBody({required this.initialType});

  @override
  ConsumerState<_QuickCaptureBody> createState() => _QuickCaptureBodyState();
}

class _QuickCaptureBodyState extends ConsumerState<_QuickCaptureBody> {
  late QuickLogType _type;
  String? _subtype;
  double? _value;
  int? _mood;
  final _noteController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _type = widget.initialType;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  bool get _needsDuration => const {
        QuickLogType.exercise,
        QuickLogType.hobby,
        QuickLogType.learning,
        QuickLogType.martialArts,
      }.contains(_type);

  bool get _needsMood => _type == QuickLogType.mood;

  List<String> get _subtypeOptions => _kSubtypeSuggestions[_type] ?? const [];

  Future<void> _save() async {
    setState(() => _saving = true);
    final todayKey = ref.read(todayKeyProvider);
    await ref.read(quickLogActionsProvider).add(
          type: _type,
          subtype: _subtype,
          value: _needsMood ? _mood?.toDouble() : _value,
          mood: _needsMood ? _mood : null,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
          dateKey: todayKey,
        );
    if (!mounted) return;
    HapticFeedback.mediumImpact();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged: ${_type.label}${_subtype != null ? ' · $_subtype' : ''}'), duration: const Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 36, height: 4, decoration: BoxDecoration(color: p.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 14),
              Text('Quick log', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 4),
              Text('Log anything in a few taps.', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 18),

              Text('What are you logging?', style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in QuickLogType.values)
                    ChoiceChip(
                      label: Text(t.label),
                      selected: _type == t,
                      onSelected: (_) => setState(() {
                        _type = t;
                        _subtype = null;
                        _value = null;
                        _mood = null;
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              if (_subtypeOptions.isNotEmpty) ...[
                PickerField<String>(
                  label: '${_type.label} type',
                  value: _subtype,
                  leadingIcon: Icons.category_outlined,
                  options: [for (final s in _subtypeOptions) PickerOption(value: s, label: s)],
                  onChanged: (v) => setState(() => _subtype = v),
                ),
                const SizedBox(height: 12),
              ],

              if (_needsDuration) ...[
                PickerField<double>(
                  label: 'Duration (minutes)',
                  value: _value,
                  leadingIcon: Icons.timer_outlined,
                  options: [for (final d in _kDurationPresets) PickerOption(value: d, label: '${d.toInt()} min')],
                  onChanged: (v) => setState(() => _value = v),
                ),
                const SizedBox(height: 12),
              ],

              if (_needsMood) ...[
                RatingSelector(label: 'Mood (1-5)', value: _mood, onChanged: (v) => setState(() => _mood = v)),
                const SizedBox(height: 12),
              ],

              TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Note (optional)', hintText: 'Anything worth remembering about this'),
              ),
              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: const Icon(Icons.bolt_rounded, size: 18),
                  label: Text(_saving ? 'Saving…' : 'Save log'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
