import 'package:flutter/material.dart';

import 'palette_scope.dart';

/// Identifies one of the four selectable app themes.
enum AppThemeId { midnight, editorial, minimal, nature }

extension AppThemeIdX on AppThemeId {
  String get label {
    switch (this) {
      case AppThemeId.midnight:
        return 'Midnight';
      case AppThemeId.editorial:
        return 'Editorial';
      case AppThemeId.minimal:
        return 'Minimal';
      case AppThemeId.nature:
        return 'Nature';
    }
  }

  String get description {
    switch (this) {
      case AppThemeId.midnight:
        return 'Dark, bold, modern fitness-app feel';
      case AppThemeId.editorial:
        return 'Warm cream & terracotta, magazine-style';
      case AppThemeId.minimal:
        return 'Soft neutrals, one clean accent';
      case AppThemeId.nature:
        return 'Deep greens, earthy and grounded';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeId.midnight:
        return Icons.dark_mode_rounded;
      case AppThemeId.editorial:
        return Icons.article_rounded;
      case AppThemeId.minimal:
        return Icons.crop_square_rounded;
      case AppThemeId.nature:
        return Icons.eco_rounded;
    }
  }
}

/// A full palette + typography contract every theme must define. Every
/// screen in the app reads colors through [AppPalette.of(context)] rather
/// than hardcoding hex values, so swapping themes recolors everything.
class AppPalette {
  final AppThemeId id;
  final Brightness brightness;

  final Color bg;
  final Color surface;
  final Color surfaceRaised;
  final Color surfaceSunken;
  final Color border;
  final Color borderSoft;

  final Color textPrimary;
  final Color textSecondary;
  final Color textFaint;

  final Color primary;
  final Color primaryOn;
  final Color primarySoft; // tinted background using primary
  final Color accent; // secondary highlight color (warnings, energy, etc.)
  final Color accentSoft;

  final Color success;
  final Color warning;
  final Color danger;
  final Color dangerSoft;

  final String displayFontFamily;
  final String bodyFontFamily;
  final String monoFontFamily;
  final double cardRadius;
  final bool useSerifDisplay;

  const AppPalette({
    required this.id,
    required this.brightness,
    required this.bg,
    required this.surface,
    required this.surfaceRaised,
    required this.surfaceSunken,
    required this.border,
    required this.borderSoft,
    required this.textPrimary,
    required this.textSecondary,
    required this.textFaint,
    required this.primary,
    required this.primaryOn,
    required this.primarySoft,
    required this.accent,
    required this.accentSoft,
    required this.success,
    required this.warning,
    required this.danger,
    required this.dangerSoft,
    required this.displayFontFamily,
    required this.bodyFontFamily,
    required this.monoFontFamily,
    required this.cardRadius,
    required this.useSerifDisplay,
  });

  /// Reads the currently active palette from the nearest [PaletteScope].
  /// This is the primary way widgets should access theme colors — e.g.
  /// `final p = AppPalette.of(context);` then `p.primary`, `p.textPrimary`, etc.
  static AppPalette of(BuildContext context) => PaletteScope.of(context);

  static AppPalette forId(AppThemeId id) {
    switch (id) {
      case AppThemeId.midnight:
        return AppPalettes.midnight;
      case AppThemeId.editorial:
        return AppPalettes.editorial;
      case AppThemeId.minimal:
        return AppPalettes.minimal;
      case AppThemeId.nature:
        return AppPalettes.nature;
    }
  }
}

class AppPalettes {
  AppPalettes._();

  // ================= MIDNIGHT — dark, bold, modern fitness app =================
  static const midnight = AppPalette(
    id: AppThemeId.midnight,
    brightness: Brightness.dark,
    bg: Color(0xFF0E1116),
    surface: Color(0xFF171B22),
    surfaceRaised: Color(0xFF1E232C),
    surfaceSunken: Color(0xFF0A0C10),
    border: Color(0xFF2A303B),
    borderSoft: Color(0xFF20242C),
    textPrimary: Color(0xFFF1F3F6),
    textSecondary: Color(0xFFA3ACBA),
    textFaint: Color(0xFF6B7280),
    primary: Color(0xFF7C5CFF),
    primaryOn: Colors.white,
    primarySoft: Color(0xFF241E3D),
    accent: Color(0xFF00E5A0),
    accentSoft: Color(0xFF0F2E27),
    success: Color(0xFF00E5A0),
    warning: Color(0xFFFFB454),
    danger: Color(0xFFFF5C7A),
    dangerSoft: Color(0xFF3A1A22),
    displayFontFamily: 'Sora',
    bodyFontFamily: 'Inter',
    monoFontFamily: 'JetBrainsMono',
    cardRadius: 20,
    useSerifDisplay: false,
  );

  // ================= EDITORIAL — cream, terracotta, magazine =================
  static const editorial = AppPalette(
    id: AppThemeId.editorial,
    brightness: Brightness.light,
    bg: Color(0xFFF8F3EA),
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFEFE7D8),
    border: Color(0xFFE3D5BE),
    borderSoft: Color(0xFFEEE3CD),
    textPrimary: Color(0xFF2B2420),
    textSecondary: Color(0xFF6B5F52),
    textFaint: Color(0xFF9C8F7E),
    primary: Color(0xFFC1522E),
    primaryOn: Colors.white,
    primarySoft: Color(0xFFF3DCCF),
    accent: Color(0xFF3D6259),
    accentSoft: Color(0xFFE1E9E3),
    success: Color(0xFF3D6259),
    warning: Color(0xFFC98A2C),
    danger: Color(0xFFB8402C),
    dangerSoft: Color(0xFFF3DCD5),
    displayFontFamily: 'Fraunces',
    bodyFontFamily: 'Inter',
    monoFontFamily: 'JetBrainsMono',
    cardRadius: 16,
    useSerifDisplay: true,
  );

  // ================= MINIMAL — soft neutrals, one clean accent =================
  static const minimal = AppPalette(
    id: AppThemeId.minimal,
    brightness: Brightness.light,
    bg: Color(0xFFFAFAFA),
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFF0F0F0),
    border: Color(0xFFE4E4E7),
    borderSoft: Color(0xFFEEEEEF),
    textPrimary: Color(0xFF18181B),
    textSecondary: Color(0xFF6B6B72),
    textFaint: Color(0xFFA3A3AB),
    primary: Color(0xFF2563EB),
    primaryOn: Colors.white,
    primarySoft: Color(0xFFE6EDFB),
    accent: Color(0xFF18181B),
    accentSoft: Color(0xFFF0F0F0),
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    danger: Color(0xFFDC2626),
    dangerSoft: Color(0xFFFBE7E7),
    displayFontFamily: 'Inter',
    bodyFontFamily: 'Inter',
    monoFontFamily: 'JetBrainsMono',
    cardRadius: 14,
    useSerifDisplay: false,
  );

  // ================= NATURE — deep greens, earthy, grounded =================
  static const nature = AppPalette(
    id: AppThemeId.nature,
    brightness: Brightness.light,
    bg: Color(0xFFF1F3EC),
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFE4E9D9),
    border: Color(0xFFD6DEC7),
    borderSoft: Color(0xFFE6EBDC),
    textPrimary: Color(0xFF1E2A1A),
    textSecondary: Color(0xFF556047),
    textFaint: Color(0xFF8A9578),
    primary: Color(0xFF2F5233),
    primaryOn: Colors.white,
    primarySoft: Color(0xFFDCE7D5),
    accent: Color(0xFFB0631F),
    accentSoft: Color(0xFFF1E1CE),
    success: Color(0xFF2F5233),
    warning: Color(0xFFB0631F),
    danger: Color(0xFFA13D2C),
    dangerSoft: Color(0xFFF1DAD2),
    displayFontFamily: 'Fraunces',
    bodyFontFamily: 'Inter',
    monoFontFamily: 'JetBrainsMono',
    cardRadius: 18,
    useSerifDisplay: true,
  );
}
