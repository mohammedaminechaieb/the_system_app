import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/core_providers.dart';
import 'app_palette.dart';

const _prefsKey = 'selected_theme_id';

/// Holds the currently selected [AppThemeId] and persists changes to
/// shared_preferences so the choice survives app restarts. Reads the saved
/// value synchronously (prefs are preloaded in main), so the first frame
/// already uses the right theme.
class ThemeController extends StateNotifier<AppThemeId> {
  final SharedPreferences _prefs;
  ThemeController(this._prefs) : super(_initial(_prefs));

  static AppThemeId _initial(SharedPreferences prefs) {
    final saved = prefs.getString(_prefsKey);
    for (final id in AppThemeId.values) {
      if (id.name == saved) return id;
    }
    return AppThemeId.midnight;
  }

  Future<void> setTheme(AppThemeId id) async {
    state = id;
    await _prefs.setString(_prefsKey, id.name);
  }
}

final themeControllerProvider = StateNotifierProvider<ThemeController, AppThemeId>((ref) => ThemeController(ref.watch(sharedPreferencesProvider)));

final currentPaletteProvider = Provider<AppPalette>((ref) {
  final id = ref.watch(themeControllerProvider);
  return AppPalette.forId(id);
});
