import 'package:flutter/material.dart';
import '../theme/app_palette.dart';

/// A tap-to-open bottom-sheet picker, used everywhere a free-text field
/// used to sit but the actual set of values is small and known (exercise
/// type, meal type, hobby category, energy rating, etc.). Replaces typing
/// with scrolling/selecting, per the "lists to choose from, not writing by
/// hand" direction.
class PickerField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<PickerOption<T>> options;
  final ValueChanged<T> onChanged;
  final IconData leadingIcon;

  const PickerField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.leadingIcon = Icons.arrow_drop_down_circle_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final selected = options.where((o) => o.value == value).toList();
    final displayLabel = selected.isNotEmpty ? selected.first.label : null;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _openPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(color: p.surfaceSunken, borderRadius: BorderRadius.circular(12), border: Border.all(color: p.border, width: 1.2)),
        child: Row(
          children: [
            if (selected.isNotEmpty && selected.first.icon != null) ...[
              Icon(selected.first.icon, size: 18, color: p.primary),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(
                    displayLabel ?? 'Select…',
                    style: TextStyle(fontSize: 14, color: displayLabel != null ? p.textPrimary : p.textFaint, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Icon(Icons.unfold_more, size: 18, color: p.textFaint),
          ],
        ),
      ),
    );
  }

  void _openPicker(BuildContext context) {
    final p = AppPalette.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(p.cardRadius))),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 36, height: 4, decoration: BoxDecoration(color: p.border, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(alignment: Alignment.centerLeft, child: Text(label, style: Theme.of(context).textTheme.titleLarge)),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final opt in options)
                        ListTile(
                          leading: opt.icon != null ? Icon(opt.icon, color: opt.value == value ? p.primary : p.textFaint) : null,
                          title: Text(opt.label, style: TextStyle(fontWeight: opt.value == value ? FontWeight.w700 : FontWeight.w500, color: opt.value == value ? p.primary : p.textPrimary)),
                          subtitle: opt.subtitle != null ? Text(opt.subtitle!, style: TextStyle(fontSize: 11.5, color: p.textFaint)) : null,
                          trailing: opt.value == value ? Icon(Icons.check_circle, color: p.primary, size: 20) : null,
                          onTap: () {
                            onChanged(opt.value);
                            Navigator.of(sheetContext).pop();
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PickerOption<T> {
  final T value;
  final String label;
  final IconData? icon;
  final String? subtitle;
  const PickerOption({required this.value, required this.label, this.icon, this.subtitle});
}

/// A horizontal row of numbered/rated chips (1–5 style scales) used for
/// energy, focus, quality ratings — tap to select, no typing or dropdown.
class RatingSelector extends StatelessWidget {
  final String label;
  final int? value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const RatingSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 5,
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Row(
          children: [
            for (int i = min; i <= max; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => onChanged(i),
                    borderRadius: BorderRadius.circular(10),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 120),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: value == i ? p.primary : p.surfaceSunken,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: value == i ? p.primary : p.border, width: 1.2),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: value == i ? p.primaryOn : p.textPrimary),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// A wheel-style duration picker (minutes) opened as a bottom sheet — used
/// wherever a numeric duration used to require typing digits.
Future<int?> showDurationPicker(BuildContext context, {int initial = 20, List<int> presets = const [5, 10, 15, 20, 30, 45, 60, 90]}) {
  final p = AppPalette.of(context);
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: p.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(p.cardRadius))),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: p.border, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 14),
            Align(alignment: Alignment.centerLeft, child: Text('Duration (minutes)', style: Theme.of(context).textTheme.titleLarge)),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final mins in presets)
                  ChoiceChip(
                    label: Text('$mins min'),
                    selected: mins == initial,
                    onSelected: (_) => Navigator.of(context).pop(mins),
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
