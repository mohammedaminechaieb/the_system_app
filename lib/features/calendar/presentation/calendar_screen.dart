import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../quicklog/data/quicklog_providers.dart';
import '../../today/domain/plan_content.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          bottom: const TabBar(tabs: [Tab(text: 'Weekly'), Tab(text: 'Hourly'), Tab(text: 'Monthly')]),
        ),
        body: TabBarView(children: [_WeeklyView(season: season), _HourlyView(season: season), const _MonthlyView()]),
      ),
    );
  }
}

class _WeeklyView extends StatelessWidget {
  final Season season;
  const _WeeklyView({required this.season});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final week = PlanContent.weekFor(season);
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        for (final day in week)
          Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day.day.toUpperCase(), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: p.primary)),
                      if (day.isRest) const Pill(text: 'REST', icon: Icons.self_improvement),
                    ],
                  ),
                  const SizedBox(height: 8),
                  BulletList(items: day.items, gap: 5),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        const SectionCard(
          title: 'Weekly generator rules',
          titleIcon: Icons.rule,
          child: BulletList(items: [
            'Martial arts today → no hard leg day the day before/after.',
            'Hard cardio yesterday → easy or rest today.',
            'Summer: extremely hot → move outdoor cardio before 9am or indoors.',
            'Winter: icy/very cold → default to indoor routine, longer warm-up.',
            'Energy 1–2 today → use the low-energy routine.',
            'Every week needs at least one full rest day. Non-negotiable.',
          ]),
        ),
      ],
    );
  }
}

class _HourlyView extends StatelessWidget {
  final Season season;
  const _HourlyView({required this.season});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final blocks = PlanContent.hourlyFor(season);
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        SectionCard(
          title: season == Season.summer ? 'Summer (remote/hybrid)' : 'Winter (full commute)',
          titleIcon: Icons.schedule,
          child: Column(
            children: [
              for (final b in blocks)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.borderSoft))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 92, child: Text(b.time, style: TextStyle(fontFamily: p.monoFontFamily, fontSize: 11.5, fontWeight: FontWeight.w700, color: p.primary))),
                      Expanded(child: Text(b.activity, style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Number of habits ticked per day (yyyy-MM-dd → count), for the monthly
/// view's markers.
final _habitDoneCountsProvider = StreamProvider<Map<String, int>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.habitLogs)..where((t) => t.done.equals(true))).watch().map((logs) {
    final counts = <String, int>{};
    for (final l in logs) {
      counts[l.date] = (counts[l.date] ?? 0) + 1;
    }
    return counts;
  });
});

final _habitLabelsProvider = StreamProvider<Map<String, String>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.habits).watch().map((rows) => {for (final h in rows) h.id: h.label});
});

final _dayLogsProvider = StreamProvider.autoDispose.family<List<QuickLog>, String>((ref, dateKey) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quickLogs)
        ..where((t) => t.date.equals(dateKey))
        ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]))
      .watch();
});

class _MonthlyView extends ConsumerStatefulWidget {
  const _MonthlyView();
  @override
  ConsumerState<_MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends ConsumerState<_MonthlyView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final counts = ref.watch(_habitDoneCountsProvider).valueOrNull ?? const {};
    final selectedKey = dateKeyOf(_selectedDay);

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TableCalendar<int>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2035, 12, 31),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // One marker per habit ticked that day (capped by the calendar).
              eventLoader: (day) => List.filled(counts[dateKeyOf(day)] ?? 0, 0),
              onDaySelected: (selected, focused) => setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              }),
              onPageChanged: (focused) => _focusedDay = focused,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: p.primarySoft, shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: p.primary, fontWeight: FontWeight.w700),
                selectedDecoration: BoxDecoration(color: p.primary, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: p.accent, shape: BoxShape.circle),
                markersMaxCount: 4,
                markerSize: 5,
                weekendTextStyle: TextStyle(color: p.accent),
              ),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _DayDetail(dateKey: selectedKey, date: _selectedDay),
      ],
    );
  }
}

class _DayDetail extends ConsumerWidget {
  final String dateKey;
  final DateTime date;
  const _DayDetail({required this.dateKey, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = AppPalette.of(context);
    final logsAsync = ref.watch(_dayLogsProvider(dateKey));
    final habitLabels = ref.watch(_habitLabelsProvider).valueOrNull ?? const {};

    return SectionCard(
      title: DateFormat('EEEE, d MMMM').format(date),
      titleIcon: Icons.event_note_outlined,
      child: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Text('Nothing logged this day.', style: TextStyle(color: p.textFaint, fontSize: 12.5));
          }
          return Column(
            children: [
              for (final l in logs)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Icon(_iconFor(l.type), size: 16, color: p.primary),
                      const SizedBox(width: 10),
                      Expanded(child: Text(_describe(l, habitLabels), style: const TextStyle(fontSize: 13))),
                    ],
                  ),
                ),
            ],
          );
        },
        loading: () => const Padding(padding: EdgeInsets.all(12), child: Center(child: CircularProgressIndicator())),
        error: (e, _) => Text('$e'),
      ),
    );
  }

  static String _describe(QuickLog l, Map<String, String> habitLabels) {
    final type = QuickLogType.values.where((t) => t.key == l.type).firstOrNull;
    final typeLabel = type?.label ?? l.type;
    if (type == QuickLogType.habit) return 'Habit · ${habitLabels[l.subtype] ?? l.subtype ?? ''}';
    final parts = <String>[typeLabel];
    if (l.subtype != null && l.subtype != 'daily' && l.subtype != 'energy') parts.add(l.subtype!);
    if (l.value != null) {
      final v = l.value! == l.value!.roundToDouble() ? l.value!.toInt().toString() : l.value!.toStringAsFixed(1);
      parts.add('$v ${l.unit ?? ''}'.trim());
    }
    return parts.join(' · ');
  }

  static IconData _iconFor(String type) => switch (type) {
        'exercise' => Icons.fitness_center,
        'meal' => Icons.restaurant,
        'hobby' => Icons.star_outline,
        'sleep' => Icons.bedtime_outlined,
        'mood' => Icons.mood,
        'habit' => Icons.check_circle_outline,
        'learning' => Icons.menu_book_outlined,
        'martial_arts' => Icons.sports_martial_arts,
        'weight' => Icons.monitor_weight_outlined,
        _ => Icons.circle_outlined,
      };
}
