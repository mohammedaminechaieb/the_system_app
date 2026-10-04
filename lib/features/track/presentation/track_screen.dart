import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/entry_toast.dart';
import '../../../core/widgets/picker_field.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../today/data/today_providers.dart';
import '../data/track_providers.dart';
import 'meal_photo_sheet.dart';

/// Fixed option sets — chosen from a picker sheet rather than typed, per
/// the "lists to choose from, not writing by hand" direction. "Other…"
/// still allows a one-off custom entry without making every entry require
/// typing.
const _kExerciseTypes = ['Strength (home)', 'Run', 'Walk', 'Cycle', 'Swim', 'Jump rope', 'Martial arts drilling', 'Tai Chi', 'Other'];
const _kMuscleGroups = ['Full body', 'Push', 'Pull', 'Legs', 'Core', 'Upper body', 'Lower body'];
const _kLearningSubjects = ['Language study', 'Reading (non-fiction)', 'Reading (fiction)', 'Online course', 'Coding practice', 'Instrument practice', 'Other'];
const _kHobbyCategories = ['Physical', 'Intellectual', 'Creative', 'Relaxing', 'Social'];
const _kMealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
const _kMartialFocus = ['Technique drilling', 'Sparring', 'Conditioning', 'Grading/test', 'Open mat', 'Other'];

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Track'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Exercise'),
              Tab(text: 'Sleep'),
              Tab(text: 'Weight'),
              Tab(text: 'Learning'),
              Tab(text: 'Martial Arts'),
              Tab(text: 'Hobbies'),
              Tab(text: 'Nutrition'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ExerciseTab(),
            _SleepTab(),
            _WeightTab(),
            _LearningTab(),
            _MartialTab(),
            _HobbyTab(),
            _NutritionTab(),
          ],
        ),
      ),
    );
  }
}

class _LogListShell extends StatelessWidget {
  final Widget form;
  final Widget list;
  const _LogListShell({required this.form, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 90),
      children: [SectionCard(child: form), const SizedBox(height: AppSpacing.lg), list],
    );
  }
}

class _EntryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  const _EntryTile({required this.icon, required this.title, required this.subtitle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18, color: p.primary),
      ),
      title: Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: p.textFaint)),
      trailing: IconButton(
        icon: Icon(Icons.close, size: 18, color: p.danger),
        tooltip: 'Delete',
        onPressed: () async {
          if (await confirmDelete(context)) onDelete();
        },
      ),
    );
  }
}

// ===== EXERCISE =====
class _ExerciseTab extends ConsumerStatefulWidget {
  const _ExerciseTab();
  @override
  ConsumerState<_ExerciseTab> createState() => _ExerciseTabState();
}

class _ExerciseTabState extends ConsumerState<_ExerciseTab> {
  String? _type;
  int? _dur;
  int? _energy;
  String? _muscleGroup;

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(exerciseLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);
    final isStrength = _type == 'Strength (home)';

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add exercise entry', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          PickerField<String>(
            label: 'Type',
            value: _type,
            leadingIcon: Icons.fitness_center,
            options: [for (final t in _kExerciseTypes) PickerOption(value: t, label: t, icon: Icons.fitness_center)],
            onChanged: (v) => setState(() {
              _type = v;
              if (v != 'Strength (home)') _muscleGroup = null;
            }),
          ),
          if (isStrength) ...[
            const SizedBox(height: 10),
            PickerField<String>(
              label: 'Muscle group focus',
              value: _muscleGroup,
              leadingIcon: Icons.accessibility_new,
              options: [for (final m in _kMuscleGroups) PickerOption(value: m, label: m)],
              onChanged: (v) => setState(() => _muscleGroup = v),
            ),
          ],
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final result = await showDurationPicker(context, initial: _dur ?? 20);
              if (result != null) setState(() => _dur = result);
            },
            child: _DisplayField(label: 'Duration', value: _dur != null ? '$_dur min' : 'Select…', icon: Icons.timer_outlined),
          ),
          const SizedBox(height: 12),
          RatingSelector(label: 'Energy during session', value: _energy, onChanged: (v) => setState(() => _energy = v)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _type == null
                  ? null
                  : () {
                      addExerciseLog(db, date: todayKey, type: _type!, durationMin: _dur, energy: _energy, muscleGroup: _muscleGroup);
                      showEntryAddedToast(context, message: 'Workout logged', icon: Icons.fitness_center);
                      setState(() {
                        _type = null;
                        _dur = null;
                        _energy = null;
                        _muscleGroup = null;
                      });
                    },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.fitness_center, text: 'No workouts logged yet.\nAdd your first session above.')
              : Column(children: [for (final l in logs) _EntryTile(icon: Icons.fitness_center, title: '${l.date} — ${l.type}${l.muscleGroup != null ? ' (${l.muscleGroup})' : ''}', subtitle: '${l.durationMin ?? '—'} min · energy ${l.energyRating ?? '—'}', onDelete: () => deleteLogRow(db, 'exercise', l.id))]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

// ===== SLEEP =====
class _SleepTab extends ConsumerStatefulWidget {
  const _SleepTab();
  @override
  ConsumerState<_SleepTab> createState() => _SleepTabState();
}

class _SleepTabState extends ConsumerState<_SleepTab> {
  String? _bed;
  String? _wake;
  double? _hours;
  int? _quality;

  static const _times = ['21:00', '21:30', '22:00', '22:30', '23:00', '23:30', '00:00', '00:30', '05:30', '06:00', '06:30', '07:00', '07:30', '08:00'];
  static const _hourOptions = [4.0, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 10.0];

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(sleepLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add sleep entry', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
              child: PickerField<String>(
                label: 'Bedtime',
                value: _bed,
                leadingIcon: Icons.bedtime_outlined,
                options: [for (final t in _times) PickerOption(value: t, label: t)],
                onChanged: (v) => setState(() => _bed = v),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PickerField<String>(
                label: 'Wake',
                value: _wake,
                leadingIcon: Icons.wb_sunny_outlined,
                options: [for (final t in _times) PickerOption(value: t, label: t)],
                onChanged: (v) => setState(() => _wake = v),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          PickerField<double>(
            label: 'Hours slept',
            value: _hours,
            leadingIcon: Icons.hourglass_bottom,
            options: [for (final h in _hourOptions) PickerOption(value: h, label: '$h h')],
            onChanged: (v) => setState(() => _hours = v),
          ),
          const SizedBox(height: 12),
          RatingSelector(label: 'Sleep quality', value: _quality, onChanged: (v) => setState(() => _quality = v)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                addSleepLog(db, date: todayKey, bedtime: _bed, wake: _wake, hours: _hours, quality: _quality);
                showEntryAddedToast(context, message: 'Sleep logged', icon: Icons.bedtime);
                setState(() {
                  _bed = null;
                  _wake = null;
                  _hours = null;
                  _quality = null;
                });
              },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.bedtime_outlined, text: 'No sleep logged yet.\nTrack a night to see your trend.')
              : Column(children: [for (final l in logs) _EntryTile(icon: Icons.bedtime, title: '${l.date} — ${l.hours ?? '—'}h', subtitle: '${l.bedtime ?? '—'} → ${l.wakeTime ?? '—'} · quality ${l.quality ?? '—'}', onDelete: () => deleteLogRow(db, 'sleep', l.id))]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

// ===== WEIGHT =====
class _WeightTab extends ConsumerStatefulWidget {
  const _WeightTab();
  @override
  ConsumerState<_WeightTab> createState() => _WeightTabState();
}

class _WeightTabState extends ConsumerState<_WeightTab> {
  double? _picked;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final logsAsync = ref.watch(weightLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);
    // Start from the last known weight rather than a generic 70 kg.
    final weight = (_picked ?? ref.watch(latestWeightProvider).valueOrNull ?? 70.0).clamp(35.0, 160.0);
    void setWeight(double v) => setState(() => _picked = (v * 10).round() / 10);

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add weekly weigh-in', style: Theme.of(context).textTheme.headlineMedium),
          const CalloutBox(icon: Icons.info_outline, text: 'Weekly, not daily — daily weighing mostly measures water, not fat.'),
          const SizedBox(height: 14),
          Center(
            child: Column(
              children: [
                Text(weight.toStringAsFixed(1), style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 42, fontWeight: FontWeight.w700, color: p.primary)),
                Text('kg', style: TextStyle(fontSize: 12, color: p.textFaint)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: weight,
            min: 35,
            max: 160,
            divisions: 1250,
            label: weight.toStringAsFixed(1),
            onChanged: setWeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(onPressed: () => setWeight((weight - 0.1).clamp(35, 160)), child: const Text('-0.1')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () => setWeight((weight - 0.5).clamp(35, 160)), child: const Text('-0.5')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () => setWeight((weight + 0.5).clamp(35, 160)), child: const Text('+0.5')),
              const SizedBox(width: 8),
              OutlinedButton(onPressed: () => setWeight((weight + 0.1).clamp(35, 160)), child: const Text('+0.1')),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await addWeightLog(db, date: todayKey, weightKg: weight);
                if (!context.mounted) return;
                showEntryAddedToast(context, message: 'Weight logged', icon: Icons.monitor_weight);
                setState(() => _picked = null);
              },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) {
          final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
          return SectionCard(
            title: 'History',
            titleIcon: Icons.history,
            child: logs.isEmpty
                ? const _EmptyState(icon: Icons.monitor_weight_outlined, text: 'No weigh-ins yet.\nWeekly check-ins build the trend line.')
                : Column(children: [
                    for (final l in logs)
                      _EntryTile(
                        icon: Icons.monitor_weight_outlined,
                        title: '${l.date} — ${l.weightKg} kg',
                        subtitle: _trendFor(sorted, l),
                        onDelete: () => deleteLogRow(db, 'weight', l.id),
                      ),
                  ]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }

  String _trendFor(List<WeightLog> logsSorted, WeightLog entry) {
    final idx = logsSorted.indexWhere((e) => e.id == entry.id);
    if (idx <= 0) return 'first entry';
    final diff = entry.weightKg - logsSorted[idx - 1].weightKg;
    if (diff.abs() < 0.05) return 'stable';
    return diff > 0 ? '↑ ${diff.toStringAsFixed(1)}kg' : '↓ ${diff.abs().toStringAsFixed(1)}kg';
  }
}

// ===== LEARNING =====
class _LearningTab extends ConsumerStatefulWidget {
  const _LearningTab();
  @override
  ConsumerState<_LearningTab> createState() => _LearningTabState();
}

class _LearningTabState extends ConsumerState<_LearningTab> {
  String? _subject;
  int? _dur;
  int? _focus;

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(learningLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add learning entry', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          PickerField<String>(
            label: 'Subject',
            value: _subject,
            leadingIcon: Icons.menu_book_outlined,
            options: [for (final s in _kLearningSubjects) PickerOption(value: s, label: s)],
            onChanged: (v) => setState(() => _subject = v),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final result = await showDurationPicker(context, initial: _dur ?? 20, presets: const [10, 15, 20, 30, 45, 60]);
              if (result != null) setState(() => _dur = result);
            },
            child: _DisplayField(label: 'Duration', value: _dur != null ? '$_dur min' : 'Select…', icon: Icons.timer_outlined),
          ),
          const SizedBox(height: 12),
          RatingSelector(label: 'Focus quality', value: _focus, onChanged: (v) => setState(() => _focus = v)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _subject == null
                  ? null
                  : () {
                      addLearningLog(db, date: todayKey, subject: _subject!, durationMin: _dur, focus: _focus);
                      showEntryAddedToast(context, message: 'Learning logged', icon: Icons.menu_book);
                      setState(() {
                        _subject = null;
                        _dur = null;
                        _focus = null;
                      });
                    },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.menu_book_outlined, text: 'No learning logged yet.\nEven 10 minutes counts.')
              : Column(children: [for (final l in logs) _EntryTile(icon: Icons.menu_book, title: '${l.date} — ${l.subject}', subtitle: '${l.durationMin ?? '—'} min · focus ${l.focusRating ?? '—'}', onDelete: () => deleteLogRow(db, 'learning', l.id))]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

// ===== MARTIAL ARTS =====
class _MartialTab extends ConsumerStatefulWidget {
  const _MartialTab();
  @override
  ConsumerState<_MartialTab> createState() => _MartialTabState();
}

class _MartialTabState extends ConsumerState<_MartialTab> {
  String? _focus;

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(martialLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add martial arts session', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          PickerField<String>(
            label: 'Focus',
            value: _focus,
            leadingIcon: Icons.sports_martial_arts,
            options: [for (final f in _kMartialFocus) PickerOption(value: f, label: f)],
            onChanged: (v) => setState(() => _focus = v),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _focus == null
                  ? null
                  : () {
                      addMartialLog(db, date: todayKey, focus: _focus);
                      showEntryAddedToast(context, message: 'Session logged', icon: Icons.sports_martial_arts);
                      setState(() => _focus = null);
                    },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.sports_martial_arts, text: 'No sessions logged yet.\nLog your first class or drill.')
              : Column(children: [for (final l in logs) _EntryTile(icon: Icons.sports_martial_arts, title: '${l.date} — ${l.focus ?? 'Session'}', subtitle: l.rank ?? l.note ?? '', onDelete: () => deleteLogRow(db, 'martial', l.id))]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

// ===== HOBBY =====
class _HobbyTab extends ConsumerStatefulWidget {
  const _HobbyTab();
  @override
  ConsumerState<_HobbyTab> createState() => _HobbyTabState();
}

class _HobbyTabState extends ConsumerState<_HobbyTab> {
  String? _category;
  String? _hobby;
  int? _dur;

  static const _hobbiesByCategory = {
    'Physical': ['Martial arts', 'Climbing', 'Swimming', 'Cycling'],
    'Intellectual': ['Language study', 'Online course', 'Chess', 'Reading'],
    'Creative': ['Cooking', 'Guitar/piano', 'Drawing', 'Writing'],
    'Relaxing': ['Reading', 'Gaming', 'Tai Chi', 'Photography'],
    'Social': ['Team sport', 'Board games', 'Friends meetup'],
  };

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(hobbyLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);
    final hobbyOptions = _category != null ? _hobbiesByCategory[_category]! : <String>[];

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add hobby entry', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          PickerField<String>(
            label: 'Category',
            value: _category,
            leadingIcon: Icons.category_outlined,
            options: [for (final c in _kHobbyCategories) PickerOption(value: c, label: c)],
            onChanged: (v) => setState(() {
              _category = v;
              _hobby = null;
            }),
          ),
          const SizedBox(height: 10),
          if (_category != null)
            PickerField<String>(
              label: 'Hobby',
              value: _hobby,
              leadingIcon: Icons.star_border,
              options: [for (final h in hobbyOptions) PickerOption(value: h, label: h)],
              onChanged: (v) => setState(() => _hobby = v),
            ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final result = await showDurationPicker(context, initial: _dur ?? 30);
              if (result != null) setState(() => _dur = result);
            },
            child: _DisplayField(label: 'Duration', value: _dur != null ? '$_dur min' : 'Select…', icon: Icons.timer_outlined),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_category == null || _hobby == null)
                  ? null
                  : () {
                      addHobbyLog(db, date: todayKey, category: _category!, hobby: _hobby!, durationMin: _dur);
                      showEntryAddedToast(context, message: 'Hobby time logged', icon: Icons.star);
                      setState(() {
                        _hobby = null;
                        _dur = null;
                      });
                    },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.star_outline, text: 'No hobby time logged yet.\nPick a category above to start.')
              : Column(children: [for (final l in logs) _EntryTile(icon: Icons.star, title: '${l.date} — ${l.hobby}', subtitle: '${l.category} · ${l.durationMin ?? '—'} min', onDelete: () => deleteLogRow(db, 'hobby', l.id))]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

// ===== NUTRITION =====
class _NutritionTab extends ConsumerStatefulWidget {
  const _NutritionTab();
  @override
  ConsumerState<_NutritionTab> createState() => _NutritionTabState();
}

class _NutritionTabState extends ConsumerState<_NutritionTab> {
  String? _meal;
  String? _description;
  bool _onPlan = true;

  static const _quickMeals = [
    'Yogurt + oats + fruit', 'Eggs + toast', 'Rice + chicken + veg', 'One-pan stir fry',
    'Lentil soup', 'Salad + protein', 'Sandwich', 'Pasta', 'Fast food', 'Restaurant meal', 'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(nutritionLogsProvider);
    final db = ref.watch(databaseProvider);
    final todayKey = ref.watch(todayKeyProvider);

    return _LogListShell(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add meal', style: Theme.of(context).textTheme.headlineMedium),
          const CalloutBox(icon: Icons.restaurant_outlined, text: 'No foods banned. Log honestly — the goal is the 80/90% pattern, not a perfect log.'),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => showMealPhotoSheet(context, ref),
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: const Text('Log with photo (AI estimate)'),
            ),
          ),
          const SizedBox(height: 10),
          const Center(child: Text('— or enter manually —', style: TextStyle(fontSize: 11))),
          const SizedBox(height: 14),
          PickerField<String>(
            label: 'Meal',
            value: _meal,
            leadingIcon: Icons.schedule,
            options: [for (final m in _kMealTypes) PickerOption(value: m, label: m)],
            onChanged: (v) => setState(() => _meal = v),
          ),
          const SizedBox(height: 10),
          PickerField<String>(
            label: 'What did you eat?',
            value: _description,
            leadingIcon: Icons.restaurant_menu,
            options: [for (final m in _quickMeals) PickerOption(value: m, label: m)],
            onChanged: (v) => setState(() => _description = v),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('On-plan', style: TextStyle(fontSize: 13.5)),
            value: _onPlan,
            onChanged: (v) => setState(() => _onPlan = v),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_meal == null || _description == null)
                  ? null
                  : () {
                      addNutritionLog(db, date: todayKey, meal: _meal!, description: _description!, onPlan: _onPlan);
                      showEntryAddedToast(context, message: 'Meal logged', icon: Icons.restaurant);
                      setState(() {
                        _description = null;
                        _onPlan = true;
                      });
                    },
              child: const Text('Add entry'),
            ),
          ),
        ],
      ),
      list: logsAsync.when(
        data: (logs) => SectionCard(
          title: 'History',
          titleIcon: Icons.history,
          child: logs.isEmpty
              ? const _EmptyState(icon: Icons.restaurant_outlined, text: 'No meals logged yet.\nLog honestly — no perfect streak needed.')
              : Column(children: [
                  for (final l in logs)
                    _NutritionEntryTile(log: l, onDelete: () => deleteLogRow(db, 'nutrition', l.id)),
                ]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('$e'),
      ),
    );
  }
}

class _NutritionEntryTile extends StatelessWidget {
  final NutritionLog log;
  final VoidCallback onDelete;
  const _NutritionEntryTile({required this.log, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final macroBits = <String>[
      if (log.estCalories != null) '${log.estCalories!.round()} kcal',
      if (log.estProteinG != null) 'P ${log.estProteinG!.round()}g',
      if (log.estCarbsG != null) 'C ${log.estCarbsG!.round()}g',
      if (log.estFatG != null) 'F ${log.estFatG!.round()}g',
    ];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: log.photoPath != null
          ? ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.file(
                File(log.photoPath!),
                width: 38,
                height: 38,
                fit: BoxFit.cover,
                cacheWidth: 120,
                // The photo file may have been cleared from storage.
                errorBuilder: (_, __, ___) => _mealIcon(p),
              ))
          : _mealIcon(p),
      title: Text('${log.date} — ${log.meal}', style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
      subtitle: Text(
        [log.description, if (!log.onPlan) "off-plan, that's fine", if (macroBits.isNotEmpty) macroBits.join(' · ')].join(' · '),
        style: TextStyle(fontSize: 12, color: p.textFaint),
      ),
      trailing: IconButton(
        icon: Icon(Icons.close, size: 18, color: p.danger),
        tooltip: 'Delete',
        onPressed: () async {
          if (await confirmDelete(context, what: 'this meal')) onDelete();
        },
      ),
    );
  }
}

Widget _mealIcon(AppPalette p) => Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: p.primarySoft, borderRadius: BorderRadius.circular(10)),
      child: Icon(Icons.restaurant, size: 18, color: p.primary),
    );

class _DisplayField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _DisplayField({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(color: p.surfaceSunken, borderRadius: BorderRadius.circular(12), border: Border.all(color: p.border, width: 1.2)),
      child: Row(
        children: [
          Icon(icon, size: 18, color: p.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10.5, color: p.textSecondary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: p.textPrimary)),
              ],
            ),
          ),
          Icon(Icons.unfold_more, size: 18, color: p.textFaint),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;
  final IconData icon;
  const _EmptyState({required this.text, this.icon = Icons.inbox_outlined});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: p.surfaceSunken, shape: BoxShape.circle),
              child: Icon(icon, size: 24, color: p.textFaint),
            ),
            const SizedBox(height: 12),
            Text(text, style: TextStyle(color: p.textFaint, fontSize: 12.5), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
