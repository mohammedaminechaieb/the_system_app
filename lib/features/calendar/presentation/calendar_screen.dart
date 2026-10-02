import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
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
                      if (day.isRest) Pill(text: 'REST', icon: Icons.self_improvement),
                    ],
                  ),
                  const SizedBox(height: 8),
                  BulletList(items: day.items, gap: 5),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        SectionCard(
          title: 'Weekly generator rules',
          titleIcon: Icons.rule,
          child: const BulletList(items: [
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

class _MonthlyView extends StatefulWidget {
  const _MonthlyView();
  @override
  State<_MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<_MonthlyView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 40),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2035, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selected, focused) => setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              }),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: p.primarySoft, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: p.primary, shape: BoxShape.circle),
                weekendTextStyle: TextStyle(color: p.accent),
              ),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('For printable monthly habit trackers, see Settings → Export & Print.', style: TextStyle(fontSize: 12.5, color: p.textFaint)),
      ],
    );
  }
}
