import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import '../database/connection.dart';

/// Singleton database instance for the whole app lifetime.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openConnection());
  ref.onDispose(() => db.close());
  return db;
});

/// Loaded once in `main()` before `runApp` and injected via a
/// ProviderScope override, so preferences (theme, season) are available
/// synchronously on the very first frame — no flash of the default theme.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden in main()');
});

final dateFormatterProvider = Provider<DateFormat>((ref) => DateFormat('yyyy-MM-dd'));

/// Formats a calendar day as the `yyyy-MM-dd` key used by every table.
String dateKeyOf(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

/// Today's date key, e.g. "2026-08-20". [todayTickerProvider] is bumped by
/// the app shell on resume and at midnight, so the app doesn't get stuck on
/// yesterday if left open overnight.
final todayTickerProvider = StateProvider<DateTime>((ref) => DateTime.now());

final todayKeyProvider = Provider<String>((ref) {
  final now = ref.watch(todayTickerProvider);
  return dateKeyOf(now);
});

/// Re-runs [load] once immediately and again whenever any of [tables]
/// changes. Drift's per-query `.watch()` only reacts to the table it
/// selects from, so providers that combine several tables must use this
/// instead of awaiting a second stream's `.first` (which goes stale).
Stream<T> watchTables<T>(AppDatabase db, Set<ResultSetImplementation> tables, Future<T> Function() load) {
  return db.customSelect('SELECT 1', readsFrom: tables).watch().asyncMap((_) => load());
}

enum Season { summer, winter }

const _kSeasonPrefsKey = 'selected_season';

/// Season is user-toggleable (see settings) and persisted; until the person
/// picks one it defaults sensibly from the month.
class SeasonController extends StateNotifier<Season> {
  final SharedPreferences _prefs;
  SeasonController(this._prefs) : super(_initial(_prefs));

  static Season _initial(SharedPreferences prefs) {
    final saved = prefs.getString(_kSeasonPrefsKey);
    for (final s in Season.values) {
      if (s.name == saved) return s;
    }
    final month = DateTime.now().month;
    // Northern-hemisphere-ish default: May–Sep = summer.
    return (month >= 5 && month <= 9) ? Season.summer : Season.winter;
  }

  void set(Season season) {
    state = season;
    _prefs.setString(_kSeasonPrefsKey, season.name);
  }

  void toggle() => set(state == Season.summer ? Season.winter : Season.summer);
}

final seasonProvider = StateNotifierProvider<SeasonController, Season>((ref) => SeasonController(ref.watch(sharedPreferencesProvider)));
