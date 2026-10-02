import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../database/app_database.dart';
import '../database/connection.dart';

/// Singleton database instance for the whole app lifetime.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openConnection());
  ref.onDispose(() => db.close());
  return db;
});

final dateFormatterProvider = Provider<DateFormat>((ref) => DateFormat('yyyy-MM-dd'));

/// Today's date key, e.g. "2026-08-20". Re-evaluated on app resume via
/// [todayTickerProvider] so the app doesn't get stuck on yesterday if left
/// open overnight.
final todayTickerProvider = StateProvider<DateTime>((ref) => DateTime.now());

final todayKeyProvider = Provider<String>((ref) {
  final now = ref.watch(todayTickerProvider);
  return DateFormat('yyyy-MM-dd').format(now);
});

enum Season { summer, winter }

/// Season is user-toggleable (see settings) but defaults sensibly from month.
final seasonProvider = StateProvider<Season>((ref) {
  final month = DateTime.now().month;
  // Northern-hemisphere-ish default: May–Sep = summer.
  return (month >= 5 && month <= 9) ? Season.summer : Season.winter;
});
