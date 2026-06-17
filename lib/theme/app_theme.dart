import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF0F0F10);
  static const Color surfaceMuted = Color(0xFF1B1B1D);
  static const Color primary = Color(0xFF657DF0);
  /// Brand wordmark / primary CTA on light landing (matches logo-forward marketing UI).
  static const Color brandBlue = Color(0xFF5E81F4);
  /// Charcoal for logo tile and secondary buttons on light auth screens.
  static const Color brandCharcoal = Color(0xFF1A1A1B);
  static const Color success = Color(0xFF37D67A);
  static const Color cyan = Color(0xFF07E4FF);
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFF9C9FA8);
  static const Color border = Color(0xFF2A2A2D);
  static const Color lightBackground = Color(0xFFF0F4F8);
  static const Color lightText = Color(0xFF0D1B3D);
  static const Color lightTagline = Color(0xFF5C6B89);
  static const Color lightLegal = Color(0xFF5C6B89);

  static bool isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
  static Color surfaceFor(BuildContext context) => isDark(context) ? surface : Colors.white;
  static Color mutedSurfaceFor(BuildContext context) => isDark(context) ? surfaceMuted : const Color(0xFFE8EDF6);
  static Color borderFor(BuildContext context) => isDark(context) ? border : const Color(0xFFD3DBE8);
  static Color secondaryTextFor(BuildContext context) => isDark(context) ? textSecondary : const Color(0xFF64718E);
}

class AppSpacing {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
}

class AppRadius {
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  /// Large pill corners for landing / auth CTAs.
  static const BorderRadius pill = BorderRadius.all(Radius.circular(20));
}

class AppTheme {
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandBlue,
        surface: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: Color(0xFFD3DBE8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: Color(0xFFD3DBE8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.brandBlue.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.brandBlue);
          }
          return const IconThemeData(color: AppColors.lightTagline);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: AppColors.brandBlue, fontWeight: FontWeight.w600, fontSize: 12);
          }
          return const TextStyle(color: AppColors.lightTagline, fontWeight: FontWeight.w500, fontSize: 12);
        }),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.25),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textSecondary);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12);
          }
          return const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500, fontSize: 12);
        }),
      ),
      useMaterial3: true,
    );
  }
}
