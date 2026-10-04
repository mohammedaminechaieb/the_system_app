import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central color palette — "field notes" aesthetic: paper, moss, rust.
class AppColors {
  AppColors._();

  static const paper = Color(0xFFF7F5F0);
  static const paperRaised = Color(0xFFFFFFFF);
  static const ink = Color(0xFF1B2B27);
  static const inkSoft = Color(0xFF3F4E49);

  static const moss = Color(0xFF3D5A50);
  static const mossDark = Color(0xFF2C4238);
  static const mossLight = Color(0xFFE3E9E5);

  static const rust = Color(0xFFB8532E);
  static const rustLight = Color(0xFFF3E1D8);

  static const sun = Color(0xFFC98A2C);
  static const sunLight = Color(0xFFF5E9D3);

  static const frost = Color(0xFF3E6E8E);
  static const frostLight = Color(0xFFDCE9EF);

  static const sage = Color(0xFF8A9A93);
  static const border = Color(0xFFD9D2C3);
  static const borderSoft = Color(0xFFE5E0D3);

  static const success = moss;
  static const warning = sun;
  static const danger = rust;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.moss,
        brightness: Brightness.light,
        primary: AppColors.moss,
        surface: AppColors.paper,
        error: AppColors.rust,
      ),
      scaffoldBackgroundColor: AppColors.paper,
    );

    final displayFont = GoogleFonts.fraunces();
    final bodyFont = GoogleFonts.inter();

    return base.copyWith(
      textTheme: base.textTheme
          .copyWith(
            displayLarge: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 32, color: AppColors.ink),
            displayMedium: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 26, color: AppColors.ink),
            displaySmall: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 21, color: AppColors.ink),
            headlineMedium: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 19, color: AppColors.mossDark),
            titleLarge: bodyFont.copyWith(fontWeight: FontWeight.w700, fontSize: 17, color: AppColors.ink),
            titleMedium: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.ink),
            bodyLarge: bodyFont.copyWith(fontSize: 15, color: AppColors.ink, height: 1.5),
            bodyMedium: bodyFont.copyWith(fontSize: 13.5, color: AppColors.inkSoft, height: 1.5),
            labelLarge: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.ink),
            labelSmall: bodyFont.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 10.5,
              color: AppColors.inkSoft,
              letterSpacing: 0.4,
            ),
          )
          .apply(fontFamily: bodyFont.fontFamily),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.mossDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: displayFont.copyWith(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
      ),
      cardTheme: CardThemeData(
        color: AppColors.paperRaised,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderSoft),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.moss,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mossDark,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: bodyFont.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border, width: 1.4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border, width: 1.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.moss, width: 1.8),
        ),
        labelStyle: bodyFont.copyWith(fontSize: 12.5, color: AppColors.inkSoft),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.mossLight,
        labelStyle: bodyFont.copyWith(color: AppColors.mossDark, fontWeight: FontWeight.w600, fontSize: 12),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.borderSoft, thickness: 1, space: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.mossLight,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return bodyFont.copyWith(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.mossDark : AppColors.sage,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(color: selected ? AppColors.mossDark : AppColors.sage);
        }),
      ),
    );
  }

  static TextStyle get mono => GoogleFonts.jetBrainsMono();
}

/// Semantic spacing scale used across the app for consistency.
class AppSpacing {
  AppSpacing._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 28.0;
}

class AppRadius {
  AppRadius._();
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const pill = 999.0;
}
