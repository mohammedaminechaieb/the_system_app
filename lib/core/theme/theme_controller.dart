import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_palette.dart';

const _prefsKey = 'selected_theme_id';

/// Holds the currently selected [AppThemeId] and persists changes to
/// shared_preferences so the choice survives app restarts.
class ThemeController extends StateNotifier<AppThemeId> {
  ThemeController() : super(AppThemeId.midnight) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved != null) {
      final match = AppThemeId.values.where((e) => e.name == saved);
      if (match.isNotEmpty) state = match.first;
    }
  }

  Future<void> setTheme(AppThemeId id) async {
    state = id;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, id.name);
  }
}

final themeControllerProvider = StateNotifierProvider<ThemeController, AppThemeId>((ref) => ThemeController());

final currentPaletteProvider = Provider<AppPalette>((ref) {
  final id = ref.watch(themeControllerProvider);
  return AppPalette.forId(id);
});
