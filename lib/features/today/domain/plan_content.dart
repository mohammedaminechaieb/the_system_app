import '../../../core/providers/core_providers.dart';

class DayPlan {
  final String day;
  final bool isRest;
  final List<String> items;
  const DayPlan({required this.day, required this.items, this.isRest = false});
}

class HourBlock {
  final String time;
  final String activity;
  const HourBlock(this.time, this.activity);
}

class EnergyPlan {
  final int level;
  final String label;
  final String description;
  const EnergyPlan(this.level, this.label, this.description);
}

class PlanContent {
  PlanContent._();

  static const List<EnergyPlan> energyPlans = [
    EnergyPlan(1, 'Exhausted', 'Walk, mobility, or meditation only. Nothing else is required today.'),
    EnergyPlan(2, 'Low', '20-minute easy home workout, or just a walk.'),
    EnergyPlan(3, 'Normal', "Today's planned session — strength, cardio, or martial arts."),
    EnergyPlan(4, 'High', 'Full planned session — go for the 45-minute version if you like.'),
    EnergyPlan(5, 'Peak', "Optional extra session — but don't let this become the daily expectation."),
  ];

  static const List<DayPlan> weekWinter = [
    DayPlan(day: 'Monday', items: [
      '06:00 wake',
      '~07:15 leave, commute 1h',
      '08:30–16:15 study/work',
      '~16:15 commute 1h home',
      'Strength 30min',
      'Read 20min',
    ]),
    DayPlan(day: 'Tuesday', items: [
      '06:00 wake', 'Commute', '08:30–16:15 study/work', 'Commute home', 'Martial arts class', 'Wind-down',
    ]),
    DayPlan(day: 'Wednesday', items: [
      '06:00 wake', 'Commute', '08:30–16:15 study/work', 'Commute home', 'Easy run/cycle 30min', 'Tai Chi 10min',
    ]),
    DayPlan(day: 'Thursday', items: [
      '06:00 wake', 'Commute', '08:30–16:15 study/work', 'Commute home', 'Strength 30min', 'Hobby time',
    ]),
    DayPlan(day: 'Friday', items: [
      '06:00 wake', 'Commute', '08:30–16:15 study/work', 'Commute home', 'Martial arts OR social',
    ]),
    DayPlan(day: 'Saturday', items: [
      'Sleep in (max +1h)', 'Tai Chi 20min', 'Free / hobby / errands', 'Sport or social evening',
    ]),
    DayPlan(day: 'Sunday', isRest: true, items: [
      'Walk / hike', 'Meditation 10min', 'Weekly review 20min', 'Easy recovery, early wind-down',
    ]),
  ];

  static const List<DayPlan> weekSummer = [
    DayPlan(day: 'Monday', items: [
      '06:30 wake', 'Remote internship work', 'Early strength 30min OR evening if cooler', 'Read 20min',
    ]),
    DayPlan(day: 'Tuesday', items: [
      '06:30 wake', 'Office day? Commute; else remote', 'Martial arts class (indoor, heat-safe)', 'Wind-down',
    ]),
    DayPlan(day: 'Wednesday', items: [
      '06:00 wake — before heat', 'Easy run/cycle 30min (early!) or swim', 'Remote internship work', 'Tai Chi 10min',
    ]),
    DayPlan(day: 'Thursday', items: [
      '06:30 wake', 'Remote internship work', 'Strength 30min (indoor, AC if possible)', 'Hobby time',
    ]),
    DayPlan(day: 'Friday', items: [
      '06:30 wake', 'Office day? Commute; else remote', 'Martial arts OR social evening',
    ]),
    DayPlan(day: 'Saturday', items: [
      'Sleep in (max +1h)', 'Tai Chi 20min (shade/indoor)', 'Free / hobby / errands', 'Evening sport once cooler',
    ]),
    DayPlan(day: 'Sunday', isRest: true, items: [
      'Early walk before heat', 'Meditation 10min', 'Weekly review 20min', 'Easy recovery, early wind-down',
    ]),
  ];

  static const List<HourBlock> hourlyWinter = [
    HourBlock('06:00', 'Wake, light exposure, water'),
    HourBlock('06:00–06:30', 'Breakfast, get ready'),
    HourBlock('06:30–07:15', 'Commute (walk a portion if possible — free cardio)'),
    HourBlock('08:30–12:30', 'Study / work'),
    HourBlock('12:30–13:15', 'Lunch, short walk'),
    HourBlock('13:15–16:15', 'Study / work'),
    HourBlock('16:15–17:00', 'Commute home'),
    HourBlock('17:00–17:30', 'Change, snack, transition'),
    HourBlock('17:30–18:00', 'Strength training (30 min home routine)'),
    HourBlock('18:00–18:45', 'Dinner'),
    HourBlock('18:45–19:15', 'Free / admin time'),
    HourBlock('19:15–19:45', 'Reading / learning block'),
    HourBlock('19:45–21:30', 'Fun block — gaming, friends, entertainment'),
    HourBlock('21:30–22:00', 'Wind-down: meditation, screens off'),
    HourBlock('22:00–22:30', 'Bed'),
  ];

  static const List<HourBlock> hourlySummer = [
    HourBlock('06:00', 'Wake — before the heat builds'),
    HourBlock('06:00–06:30', 'Water, light breakfast'),
    HourBlock('06:30–07:00', "Easy cardio outdoors NOW (run/walk/cycle) while it's cool"),
    HourBlock('07:00–08:30', 'Shower, breakfast, settle in'),
    HourBlock('08:30–12:30', 'Remote internship work (or commute if an office day)'),
    HourBlock('12:30–13:15', 'Lunch — indoors/shade, hydrate well'),
    HourBlock('13:15–17:00', 'Remote internship work'),
    HourBlock('17:00–17:30', 'Snack, transition — heat usually still high, stay indoors'),
    HourBlock('17:30–18:15', 'Strength training indoors (AC/fan) or martial arts class'),
    HourBlock('18:15–19:00', 'Dinner'),
    HourBlock('19:00–19:30', 'Reading / learning block'),
    HourBlock('19:30–21:00', "Once it's cooler: optional sport, walk, or fun block"),
    HourBlock('21:00–22:00', 'Wind-down, screens low'),
    HourBlock('22:00–22:30', 'Bed'),
  ];

  static List<DayPlan> weekFor(Season s) => s == Season.summer ? weekSummer : weekWinter;
  static List<HourBlock> hourlyFor(Season s) => s == Season.summer ? hourlySummer : hourlyWinter;

  static DayPlan todayPlan(Season s, DateTime now) {
    final week = weekFor(s);
    final idx = (now.weekday - 1).clamp(0, 6); // DateTime.weekday: Mon=1..Sun=7
    return week[idx];
  }

  static EnergyPlan energyPlanFor(int level) => energyPlans.firstWhere((e) => e.level == level);
}
