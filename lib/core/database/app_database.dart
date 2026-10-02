import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// One row per calendar day: energy level, quick numbers, gate completion.
class DailyState extends Table {
  TextColumn get date => text()(); // yyyy-MM-dd, primary key
  IntColumn get energyLevel => integer().nullable()(); // 1-5
  RealColumn get sleepHours => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  IntColumn get steps => integer().nullable()();
  BoolColumn get gatePassed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get gatePassedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {date};
}

/// Definition of a trackable habit (mostly fixed, but extensible).
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get icon => text().withDefault(const Constant('check'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isCore => boolean().withDefault(const Constant(true))(); // core = required for gate
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  // 1 = easy, 2 = medium, 3 = hard — scales points contributed to streaks/score.
  IntColumn get tier => integer().withDefault(const Constant(1))();
  // Optional "HH:mm" — when set, this habit can be scheduled as a real
  // calendar block (see HabitCalendarEvents) rather than just tracked.
  TextColumn get scheduledTime => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One row per (habit, date) completion.
class HabitLogs extends Table {
  TextColumn get habitId => text()();
  TextColumn get date => text()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  // null = not yet resolved / not scheduled; 'skipped' = chose not to do it;
  // 'missed_opportunity' = a scheduled calendar block passed unlogged.
  // Distinct from `done` so the gate/streak logic can eventually treat a
  // missed opportunity differently from an active choice to skip, without
  // making the gate itself more demanding.
  TextColumn get outcome => text().nullable()();

  @override
  Set<Column> get primaryKey => {habitId, date};
}

/// Streak + penalty ledger — persists points, current streak, freezes used.
class StreakState extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))(); // singleton row, id=0
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  IntColumn get totalPoints => integer().withDefault(const Constant(0))();
  IntColumn get streakFreezesAvailable => integer().withDefault(const Constant(2))();
  TextColumn get lastCompletedDate => text().nullable()();
  TextColumn get lastPenaltyDate => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Generic logged entries: exercise, sleep detail, weight, learning, martial arts, hobby.
class ExerciseLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get type => text()();
  IntColumn get durationMin => integer().nullable()();
  IntColumn get energyRating => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // Finer-grained tracking within "exercise" for strength sessions —
  // e.g. 'legs', 'push', 'pull', 'full_body'. Nullable since it only
  // applies to some exercise types (running has no muscle group).
  TextColumn get muscleGroup => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SleepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get bedtime => text().nullable()();
  TextColumn get wakeTime => text().nullable()();
  RealColumn get hours => real().nullable()();
  IntColumn get quality => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WeightLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  RealColumn get weightKg => real()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class LearningLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get subject => text()();
  IntColumn get durationMin => integer().nullable()();
  IntColumn get focusRating => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MartialArtsLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get focus => text().nullable()();
  TextColumn get rank => text().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class HobbyLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get category => text()();
  TextColumn get hobby => text()();
  IntColumn get durationMin => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class NutritionLogs extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get meal => text()(); // breakfast/lunch/dinner/snack
  TextColumn get description => text()();
  BoolColumn get onPlan => boolean().withDefault(const Constant(true))();
  // Photo-based logging (see GeminiService.analyzeMealPhoto): the photo is
  // kept as a local file path only, never uploaded anywhere but the
  // single Gemini vision call the person triggers. Estimates are always
  // editable afterward — `aiEstimated` just flags they started as a guess.
  TextColumn get photoPath => text().nullable()();
  RealColumn get estCalories => real().nullable()();
  RealColumn get estProteinG => real().nullable()();
  RealColumn get estCarbsG => real().nullable()();
  RealColumn get estFatG => real().nullable()();
  BoolColumn get aiEstimated => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class WeeklyReviews extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get win => text().nullable()();
  TextColumn get adjust => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tracks which Atomic Habits chapters have been read/completed.
class ReadingProgress extends Table {
  TextColumn get chapterId => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get lastPageIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {chapterId};
}

/// User preferences: season, martial art chosen, onboarding done, etc.
class UserPrefs extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

/// The unified cross-domain log. Every tracking screen (exercise, sleep,
/// weight, learning, martial arts, hobby, nutrition, mood, habit, and any
/// future category) writes one row here in addition to its own
/// domain-specific table, so the dashboard's correlation engine and the
/// quick-capture entry point have a single place to query across every
/// category without needing to know about each domain table individually.
class QuickLogs extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'exercise', 'meal', 'hobby', 'sleep', 'mood', 'habit', ...
  TextColumn get subtype => text().nullable()(); // 'running', 'guitar', 'breakfast', ...
  RealColumn get value => real().nullable()(); // duration, reps, calories, hours, etc.
  TextColumn get unit => text().nullable()(); // 'minutes', 'reps', 'kcal', 'hours', ...
  IntColumn get mood => integer().nullable()(); // 1-5, optional
  TextColumn get note => text().nullable()();
  TextColumn get date => text()(); // yyyy-MM-dd — indexed for fast per-day/range queries
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Links a scheduled habit's calendar block (see CalendarService) to the
/// specific (habit, date) it was created for, so the app can look the
/// event back up to check whether it passed unlogged.
class HabitCalendarEvents extends Table {
  TextColumn get habitId => text()();
  TextColumn get date => text()();
  TextColumn get eventId => text()(); // device_calendar event id
  TextColumn get calendarId => text()();
  DateTimeColumn get scheduledStart => dateTime()();
  DateTimeColumn get scheduledEnd => dateTime()();

  @override
  Set<Column> get primaryKey => {habitId, date};
}

/// Which installed apps the person has chosen to soft-restrict. Screen
/// time on these apps is what gets "paid for" by logged activity — see
/// ScreenTimeService and the streak engine's earnScreenTime.
class BlockedApps extends Table {
  TextColumn get packageName => text()();
  TextColumn get label => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {packageName};
}

/// One row per day: minutes of screen time earned back by logged activity
/// vs. minutes already redeemed. Extends the existing streak/penalty
/// engine rather than replacing it — this is purely additive currency.
class ScreenTimeCredits extends Table {
  TextColumn get date => text()();
  IntColumn get earnedMinutes => integer().withDefault(const Constant(0))();
  IntColumn get usedMinutes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}

/// Cached AI-generated weekly reviews (distinct from the person's own
/// quick win/adjust notes in WeeklyReviews). Generated on demand, not
/// re-requested automatically, so it's never re-calling the API just
/// because a screen was reopened. `weekStart` is the primary key so
/// regenerating a review for the same week is a clean upsert.
class AiWeeklyReviews extends Table {
  TextColumn get weekStart => text()(); // yyyy-MM-dd, Monday of that week
  TextColumn get content => text()();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {weekStart};
}

@DriftDatabase(tables: [
  DailyState,
  Habits,
  HabitLogs,
  StreakState,
  ExerciseLogs,
  SleepLogs,
  WeightLogs,
  LearningLogs,
  MartialArtsLogs,
  HobbyLogs,
  NutritionLogs,
  WeeklyReviews,
  ReadingProgress,
  UserPrefs,
  QuickLogs,
  HabitCalendarEvents,
  BlockedApps,
  ScreenTimeCredits,
  AiWeeklyReviews,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaults(this);
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(quickLogs);
          }
          if (from < 3) {
            await m.addColumn(habits, habits.tier);
            await m.addColumn(habits, habits.scheduledTime);
            await m.addColumn(habitLogs, habitLogs.outcome);
            await m.addColumn(exerciseLogs, exerciseLogs.muscleGroup);
            await m.addColumn(nutritionLogs, nutritionLogs.photoPath);
            await m.addColumn(nutritionLogs, nutritionLogs.estCalories);
            await m.addColumn(nutritionLogs, nutritionLogs.estProteinG);
            await m.addColumn(nutritionLogs, nutritionLogs.estCarbsG);
            await m.addColumn(nutritionLogs, nutritionLogs.estFatG);
            await m.addColumn(nutritionLogs, nutritionLogs.aiEstimated);
            await m.createTable(habitCalendarEvents);
            await m.createTable(blockedApps);
            await m.createTable(screenTimeCredits);
            await m.createTable(aiWeeklyReviews);
          }
        },
      );
}

Future<void> _seedDefaults(AppDatabase db) async {
  // Seed the four core habits.
  const defaults = [
    HabitsCompanion(id: Value('trained'), label: Value('Trained today'), icon: Value('fitness_center'), sortOrder: Value(0)),
    HabitsCompanion(id: Value('meditated'), label: Value('Meditated'), icon: Value('self_improvement'), sortOrder: Value(1)),
    HabitsCompanion(id: Value('slept_on_time'), label: Value('Slept on time'), icon: Value('bedtime'), sortOrder: Value(2)),
    HabitsCompanion(id: Value('read'), label: Value('Read / learned something'), icon: Value('menu_book'), sortOrder: Value(3)),
  ];
  for (final h in defaults) {
    await db.into(db.habits).insert(h);
  }
  await db.into(db.streakState).insert(const StreakStateCompanion(id: Value(0)));
}
