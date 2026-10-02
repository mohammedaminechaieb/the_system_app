import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

/// Builds a full [ThemeData] from an [AppPalette]. Every switchable theme
/// goes through this single factory so behavior (radii, spacing, component
/// shapes) stays consistent while only colors and fonts vary.
class AppThemeBuilder {
  AppThemeBuilder._();

  static ThemeData build(AppPalette p) {
    final displayFont = p.useSerifDisplay ? GoogleFonts.fraunces() : GoogleFonts.sora();
    final bodyFont = GoogleFonts.inter();

    final base = ThemeData(
      useMaterial3: true,
      brightness: p.brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.primary,
        brightness: p.brightness,
        primary: p.primary,
        surface: p.surface,
        error: p.danger,
      ),
      scaffoldBackgroundColor: p.bg,
    );

    return base.copyWith(
      textTheme: base.textTheme
          .copyWith(
            displayLarge: displayFont.copyWith(fontWeight: FontWeight.w700, fontSize: 30, color: p.textPrimary, height: 1.15),
            displayMedium: displayFont.copyWith(fontWeight: FontWeight.w700, fontSize: 24, color: p.textPrimary, height: 1.2),
            displaySmall: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 19, color: p.textPrimary),
            headlineMedium: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 17, color: p.textPrimary),
            titleLarge: bodyFont.copyWith(fontWeight: FontWeight.w700, fontSize: 15.5, color: p.textPrimary),
            titleMedium: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 14, color: p.textPrimary),
            bodyLarge: bodyFont.copyWith(fontSize: 14.5, color: p.textPrimary, height: 1.5),
            bodyMedium: bodyFont.copyWith(fontSize: 13, color: p.textSecondary, height: 1.5),
            labelLarge: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 12.5, color: p.textPrimary),
            labelSmall: bodyFont.copyWith(fontWeight: FontWeight.w700, fontSize: 10, color: p.textSecondary, letterSpacing: 0.5),
          )
          .apply(bodyColor: p.textPrimary, displayColor: p.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: p.bg,
        foregroundColor: p.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: displayFont.copyWith(fontWeight: FontWeight.w700, fontSize: 19, color: p.textPrimary),
        iconTheme: IconThemeData(color: p.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: p.surfaceRaised,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(p.cardRadius),
          side: BorderSide(color: p.borderSoft),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: p.primaryOn,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(p.cardRadius * 0.7)),
          textStyle: bodyFont.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.textPrimary,
          side: BorderSide(color: p.border, width: 1.4),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(p.cardRadius * 0.7)),
          textStyle: bodyFont.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: p.primary, textStyle: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 13.5)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surfaceSunken,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: p.border, width: 1.2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: p.border, width: 1.2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: p.primary, width: 1.8)),
        labelStyle: bodyFont.copyWith(fontSize: 12.5, color: p.textSecondary),
        hintStyle: bodyFont.copyWith(fontSize: 13, color: p.textFaint),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: p.primarySoft,
        labelStyle: bodyFont.copyWith(color: p.primary, fontWeight: FontWeight.w600, fontSize: 12),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: DividerThemeData(color: p.borderSoft, thickness: 1, space: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        indicatorColor: p.primarySoft,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return bodyFont.copyWith(fontSize: 10.5, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: selected ? p.primary : p.textFaint);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(color: selected ? p.primary : p.textFaint);
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.primary : p.textFaint),
        trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? p.primarySoft : p.borderSoft),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: p.primary, linearTrackColor: p.borderSoft),
    );
  }
}
