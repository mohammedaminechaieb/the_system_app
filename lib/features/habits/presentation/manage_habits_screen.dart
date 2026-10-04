import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/calendar/calendar_service.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/habit_icons.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/habits_providers.dart';

const _kTierLabels = {1: 'Easy', 2: 'Medium', 3: 'Hard'};

/// Lets the person set a difficulty tier per habit (easy/medium/hard —
/// scales the points it contributes, see StreakEngine.awardHabitPoint),
/// mark it core/non-core, archive it, or add a brand new one.
class ManageHabitsScreen extends ConsumerWidget {
  const ManageHabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final habitsAsync = ref.watch(_allHabitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage habits'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => _showAddHabitSheet(context, ref))],
      ),
      body: habitsAsync.when(
        data: (habits) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              'Tier scales how many points a habit is worth — a hard habit contributes more to your daily score than an easy one. Core habits are required for the daily gate.',
              style: TextStyle(fontSize: 12.5, color: p.textFaint),
            ),
            const SizedBox(height: 14),
            for (final h in habits) _HabitManageTile(habit: h),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
      ),
    );
  }

  void _showAddHabitSheet(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final labelController = TextEditingController();
    String icon = 'check';
    int tier = 1;
    bool isCore = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: p.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(p.cardRadius))),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(sheetContext).viewInsets.bottom, left: 18, right: 18, top: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New habit', style: Theme.of(sheetContext).textTheme.displaySmall),
                const SizedBox(height: 14),
                TextField(
                  controller: labelController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  // Rebuild so the "Add habit" button enables as soon as
                  // there's a name.
                  onChanged: (_) => setSheetState(() {}),
                  decoration: const InputDecoration(labelText: 'Habit name'),
                ),
                const SizedBox(height: 12),
                PickerField<String>(
                  label: 'Icon',
                  value: icon,
                  leadingIcon: habitIcon(icon),
                  options: [for (final e in kHabitIcons.entries) PickerOption(value: e.key, label: habitIconLabel(e.key), icon: e.value)],
                  onChanged: (v) => setSheetState(() => icon = v),
                ),
                const SizedBox(height: 12),
                PickerField<int>(
                  label: 'Difficulty tier',
                  value: tier,
                  options: [for (final t in _kTierLabels.entries) PickerOption(value: t.key, label: t.value)],
                  onChanged: (v) => setSheetState(() => tier = v),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Required for daily gate'),
                  value: isCore,
                  onChanged: (v) => setSheetState(() => isCore = v),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: labelController.text.trim().isEmpty
                        ? null
                        : () async {
                            await ref.read(habitManagementProvider).create(label: labelController.text.trim(), icon: icon, tier: tier, isCore: isCore);
                            if (sheetContext.mounted) Navigator.of(sheetContext).pop();
                          },
                    child: const Text('Add habit'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    ).whenComplete(labelController.dispose);
  }
}

final _allHabitsProvider = StreamProvider<List<Habit>>((ref) => ref.watch(habitManagementProvider).watchAll());

Future<void> _pickScheduleTime(BuildContext context, WidgetRef ref, Habit habit) async {
  final initial = habit.scheduledTime != null
      ? TimeOfDay(hour: int.parse(habit.scheduledTime!.split(':')[0]), minute: int.parse(habit.scheduledTime!.split(':')[1]))
      : const TimeOfDay(hour: 7, minute: 0);
  final picked = await showTimePicker(context: context, initialTime: initial);
  if (picked == null) return;
  final hhmm = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
  if (hhmm == habit.scheduledTime) return;
  await ref.read(habitManagementProvider).setScheduledTime(habit.id, hhmm);

  final created = await ref.read(calendarServiceProvider).scheduleForToday(habit.id, habit.label, hhmm);
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(created ? "Scheduled — today's block added to your calendar." : "Time saved, but couldn't add a calendar block (check calendar permission).")),
  );
}

/// Changing which habits are core (or active) changes what today's gate
/// requires, so re-check it rather than leaving a stale pass/fail.
Future<void> _refreshGate(WidgetRef ref) => ref.read(habitActionsProvider).reevaluateGate(ref.read(todayKeyProvider));

class _HabitManageTile extends ConsumerWidget {
  final Habit habit;
  const _HabitManageTile({required this.habit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final management = ref.read(habitManagementProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(habitIcon(habit.icon), size: 18, color: habit.archived ? p.textFaint : p.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    habit.label,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5, color: habit.archived ? p.textFaint : p.textPrimary, decoration: habit.archived ? TextDecoration.lineThrough : null),
                  ),
                ),
                Switch(
                  value: !habit.archived,
                  onChanged: (v) async {
                    await management.setArchived(habit.id, !v);
                    if (!v) await ref.read(calendarServiceProvider).cancelForToday(habit.id);
                    await _refreshGate(ref);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: PickerField<int>(
                    label: 'Tier',
                    value: habit.tier,
                    options: [for (final t in _kTierLabels.entries) PickerOption(value: t.key, label: t.value)],
                    onChanged: (v) => management.setTier(habit.id, v),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Core', style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
                    Switch(
                      value: habit.isCore,
                      onChanged: (v) async {
                        await management.setCore(habit.id, v);
                        await _refreshGate(ref);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.event_outlined, size: 16, color: p.textFaint),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    habit.scheduledTime != null ? 'Scheduled at ${habit.scheduledTime} — creates a calendar block each day' : 'Not scheduled — tracked as a checkbox only',
                    style: TextStyle(fontSize: 11.5, color: p.textFaint),
                  ),
                ),
                TextButton(
                  onPressed: () => _pickScheduleTime(context, ref, habit),
                  child: Text(habit.scheduledTime != null ? 'Change' : 'Schedule'),
                ),
                if (habit.scheduledTime != null)
                  IconButton(
                    icon: Icon(Icons.close, size: 16, color: p.danger),
                    tooltip: 'Remove schedule',
                    onPressed: () async {
                      await management.setScheduledTime(habit.id, null);
                      await ref.read(calendarServiceProvider).cancelForToday(habit.id);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
