import 'package:flutter_test/flutter_test.dart';
import 'package:the_system/core/database/app_database.dart';
import 'package:the_system/core/providers/streak_engine.dart';
import 'package:the_system/features/dashboard/data/correlation_providers.dart';
import 'package:the_system/features/habits/data/habits_providers.dart';
import 'package:the_system/features/quicklog/data/quicklog_providers.dart';
import 'package:the_system/features/track/presentation/meal_photo_sheet.dart';

QuickLog _log(QuickLogType type, String date, double? value) => QuickLog(
      id: '$type-$date-$value-${DateTime.now().microsecondsSinceEpoch}',
      type: type.key,
      value: value,
      date: date,
      timestamp: DateTime(2026, 1, 1),
    );

void main() {
  group('computeReconciliation', () {
    final today = DateTime(2026, 3, 10);

    test('nothing to charge when last completion was yesterday or today', () {
      for (final last in [DateTime(2026, 3, 9), DateTime(2026, 3, 10)]) {
        expect(computeReconciliation(today: today, lastCompleted: last, streak: 5, points: 50, freezes: 2), isNull);
      }
    });

    test('freezes absorb misses before the streak breaks', () {
      // Last done on the 7th → 8th and 9th missed, both covered by freezes.
      final r = computeReconciliation(today: today, lastCompleted: DateTime(2026, 3, 7), streak: 5, points: 50, freezes: 2)!;
      expect(r.missedDays, 2);
      expect(r.freezesUsed, 2);
      expect(r.freezesLeft, 0);
      expect(r.newStreak, 5);
      expect(r.newPoints, 50);
      expect(r.penalized, isFalse);
    });

    test('misses beyond the freezes reset the streak and cost points', () {
      final r = computeReconciliation(today: today, lastCompleted: DateTime(2026, 3, 5), streak: 5, points: 50, freezes: 1)!;
      expect(r.missedDays, 4);
      expect(r.freezesUsed, 1);
      expect(r.newStreak, 0);
      expect(r.newPoints, 50 + StreakRules.penaltyPerMissedDay * 3);
      expect(r.penalized, isTrue);
    });

    test('points never go negative', () {
      final r = computeReconciliation(today: today, lastCompleted: DateTime(2026, 2, 1), streak: 3, points: 10, freezes: 0)!;
      expect(r.newPoints, 0);
    });

    test('a gap already reconciled is not charged again (relaunch same day)', () {
      // First launch on the 10th charged the 6th–9th and recorded
      // "reconciled through the 9th". A second launch must charge nothing.
      expect(
        computeReconciliation(today: today, lastCompleted: DateTime(2026, 3, 5), reconciledThrough: DateTime(2026, 3, 9), streak: 0, points: 18, freezes: 0),
        isNull,
      );
    });

    test('after a reconciled gap only the new days are charged', () {
      // Reconciled through the 9th, reopened on the 12th → 10th and 11th missed.
      final r = computeReconciliation(today: DateTime(2026, 3, 12), lastCompleted: DateTime(2026, 3, 5), reconciledThrough: DateTime(2026, 3, 9), streak: 0, points: 18, freezes: 0)!;
      expect(r.missedDays, 2);
    });
  });

  group('computeHabitStreak', () {
    final today = DateTime(2026, 3, 10);

    test('counts consecutive days ending today', () {
      expect(computeHabitStreak({'2026-03-10', '2026-03-09', '2026-03-08', '2026-03-06'}, today), 3);
    });

    test('an unlogged today does not zero the streak', () {
      expect(computeHabitStreak({'2026-03-09', '2026-03-08'}, today), 2);
    });

    test('a gap before yesterday means no streak', () {
      expect(computeHabitStreak({'2026-03-07'}, today), 0);
    });

    test('crosses month boundaries', () {
      expect(computeHabitStreak({'2026-03-01', '2026-02-28', '2026-02-27'}, DateTime(2026, 3, 1)), 3);
    });
  });

  group('buildSeriesByType', () {
    test('sums amounts but averages readings on the same day', () {
      final series = buildSeriesByType([
        _log(QuickLogType.exercise, '2026-03-10', 20),
        _log(QuickLogType.exercise, '2026-03-10', 30),
        // Sleep logged both on Today and in Track — must not become 14h.
        _log(QuickLogType.sleep, '2026-03-10', 7),
        _log(QuickLogType.sleep, '2026-03-10', 7),
        _log(QuickLogType.mood, '2026-03-10', 2),
        _log(QuickLogType.mood, '2026-03-10', 4),
      ]);
      final day = DateTime(2026, 3, 10);
      expect(series[QuickLogType.exercise]!.byDay[day], 50);
      expect(series[QuickLogType.sleep]!.byDay[day], 7);
      expect(series[QuickLogType.mood]!.byDay[day], 3);
    });

    test('ignores unknown categories instead of misfiling them', () {
      final series = buildSeriesByType([
        QuickLog(id: 'x', type: 'something_new', value: 5, date: '2026-03-10', timestamp: DateTime(2026)),
      ]);
      expect(series, isEmpty);
    });
  });

  group('pearsonCorrelation', () {
    Map<DateTime, double> days(List<double> v) => {for (var i = 0; i < v.length; i++) DateTime(2026, 3, 1 + i): v[i]};

    test('perfect positive and negative correlation', () {
      expect(pearsonCorrelation(days([1, 2, 3, 4, 5]), days([2, 4, 6, 8, 10])), closeTo(1, 1e-9));
      expect(pearsonCorrelation(days([1, 2, 3, 4, 5]), days([10, 8, 6, 4, 2])), closeTo(-1, 1e-9));
    });

    test('null with too few shared days or no variance', () {
      expect(pearsonCorrelation(days([1, 2, 3]), days([1, 2, 3])), isNull);
      expect(pearsonCorrelation(days([5, 5, 5, 5]), days([1, 2, 3, 4])), isNull);
    });
  });

  test('defaultMealForNow picks a meal from the time of day', () {
    expect(defaultMealForNow(DateTime(2026, 1, 1, 8)), 'Breakfast');
    expect(defaultMealForNow(DateTime(2026, 1, 1, 13)), 'Lunch');
    expect(defaultMealForNow(DateTime(2026, 1, 1, 19)), 'Dinner');
    expect(defaultMealForNow(DateTime(2026, 1, 1, 16)), 'Snack');
  });
}
