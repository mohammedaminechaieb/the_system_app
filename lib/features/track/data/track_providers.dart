import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../quicklog/data/quicklog_providers.dart';

const _uuid = Uuid();

/// Mirrors a domain-specific log entry into the unified QuickLog table so
/// the dashboard's rollups and correlation engine can query every category
/// from one place, without needing to know about each domain table. This
/// is intentionally "fire and forget" alongside the structured insert —
/// the domain table stays the source of truth for its own detail screen.
Future<void> _mirrorToQuickLog(
  AppDatabase db, {
  required QuickLogType type,
  String? subtype,
  double? value,
  String? unit,
  String? note,
  required String dateKey,
}) {
  return QuickLogActions(db).add(
    type: type,
    subtype: subtype,
    value: value,
    unit: unit,
    note: note,
    dateKey: dateKey,
  );
}

// ===== EXERCISE =====
final exerciseLogsProvider = StreamProvider<List<ExerciseLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.exerciseLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addExerciseLog(AppDatabase db, {required String date, required String type, int? durationMin, int? energy, String? notes, String? muscleGroup}) async {
  await db.into(db.exerciseLogs).insert(ExerciseLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        type: Value(type),
        durationMin: Value(durationMin),
        energyRating: Value(energy),
        notes: Value(notes),
        muscleGroup: Value(muscleGroup),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.exercise, subtype: muscleGroup ?? type, value: durationMin?.toDouble(), unit: 'minutes', note: notes, dateKey: date);
}

// ===== SLEEP =====
final sleepLogsProvider = StreamProvider<List<SleepLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.sleepLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addSleepLog(AppDatabase db, {required String date, String? bedtime, String? wake, double? hours, int? quality}) async {
  await db.into(db.sleepLogs).insert(SleepLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        bedtime: Value(bedtime),
        wakeTime: Value(wake),
        hours: Value(hours),
        quality: Value(quality),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.sleep, value: hours, unit: 'hours', dateKey: date);
}

// ===== WEIGHT =====
final weightLogsProvider = StreamProvider<List<WeightLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.weightLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addWeightLog(AppDatabase db, {required String date, required double weightKg, String? notes}) async {
  await db.into(db.weightLogs).insert(WeightLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        weightKg: Value(weightKg),
        notes: Value(notes),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.weight, value: weightKg, unit: 'kg', note: notes, dateKey: date);
}

// ===== LEARNING =====
final learningLogsProvider = StreamProvider<List<LearningLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.learningLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addLearningLog(AppDatabase db, {required String date, required String subject, int? durationMin, int? focus}) async {
  await db.into(db.learningLogs).insert(LearningLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        subject: Value(subject),
        durationMin: Value(durationMin),
        focusRating: Value(focus),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.learning, subtype: subject, value: durationMin?.toDouble(), unit: 'minutes', dateKey: date);
}

// ===== MARTIAL ARTS =====
final martialLogsProvider = StreamProvider<List<MartialArtsLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.martialArtsLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addMartialLog(AppDatabase db, {required String date, String? focus, String? rank, String? note}) async {
  await db.into(db.martialArtsLogs).insert(MartialArtsLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        focus: Value(focus),
        rank: Value(rank),
        note: Value(note),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.martialArts, subtype: focus, note: note, dateKey: date);
}

// ===== HOBBY =====
final hobbyLogsProvider = StreamProvider<List<HobbyLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.hobbyLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addHobbyLog(AppDatabase db, {required String date, required String category, required String hobby, int? durationMin}) async {
  await db.into(db.hobbyLogs).insert(HobbyLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        category: Value(category),
        hobby: Value(hobby),
        durationMin: Value(durationMin),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.hobby, subtype: hobby, value: durationMin?.toDouble(), unit: 'minutes', dateKey: date);
}

// ===== NUTRITION =====
final nutritionLogsProvider = StreamProvider<List<NutritionLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.nutritionLogs)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();
});

Future<void> addNutritionLog(
  AppDatabase db, {
  required String date,
  required String meal,
  required String description,
  bool onPlan = true,
  double? calories,
  String? photoPath,
  double? estProteinG,
  double? estCarbsG,
  double? estFatG,
  bool aiEstimated = false,
}) async {
  await db.into(db.nutritionLogs).insert(NutritionLogsCompanion(
        id: Value(_uuid.v4()),
        date: Value(date),
        meal: Value(meal),
        description: Value(description),
        onPlan: Value(onPlan),
        photoPath: Value(photoPath),
        estCalories: Value(calories),
        estProteinG: Value(estProteinG),
        estCarbsG: Value(estCarbsG),
        estFatG: Value(estFatG),
        aiEstimated: Value(aiEstimated),
      ));
  await _mirrorToQuickLog(db, type: QuickLogType.meal, subtype: meal, value: calories, unit: 'kcal', note: description, dateKey: date);
}

// ===== DELETE (generic by table name) =====
Future<void> deleteLogRow(AppDatabase db, String table, String id) async {
  switch (table) {
    case 'exercise':
      await (db.delete(db.exerciseLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'sleep':
      await (db.delete(db.sleepLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'weight':
      await (db.delete(db.weightLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'learning':
      await (db.delete(db.learningLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'martial':
      await (db.delete(db.martialArtsLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'hobby':
      await (db.delete(db.hobbyLogs)..where((t) => t.id.equals(id))).go();
      break;
    case 'nutrition':
      await (db.delete(db.nutritionLogs)..where((t) => t.id.equals(id))).go();
      break;
  }
}
