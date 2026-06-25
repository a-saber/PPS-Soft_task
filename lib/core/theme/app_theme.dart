import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Builds the app's light and dark [ThemeData]. Both share the exact same
/// [AppColors.primary] (orange) — only surfaces/text/borders flip between
/// light and dark. Nothing here is hardcoded outside of [AppColors].
abstract class AppTheme {
  static const double _radius = 12;

  // ---------------------------------------------------------------------
  // Light
  // ---------------------------------------------------------------------
  static ThemeData get light {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryDark,
      onSecondary: AppColors.onPrimary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      outline: AppColors.lightBorder,
    );

    return _build(
      colorScheme: colorScheme,
      brightness: Brightness.light,
      scaffoldBackground: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightDivider,
      onBackground: AppColors.lightOnBackground,
      mutedText: AppColors.lightOnSurfaceMuted,
      inputFill: AppColors.lightSurfaceVariant,
    );
  }

  // ---------------------------------------------------------------------
  // Dark
  // ---------------------------------------------------------------------
  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.onPrimary,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      outline: AppColors.darkBorder,
    );

    return _build(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackground: AppColors.darkBackground,
      cardColor: AppColors.darkSurface,
      dividerColor: AppColors.darkDivider,
      onBackground: AppColors.darkOnBackground,
      mutedText: AppColors.darkOnSurfaceMuted,
      inputFill: AppColors.darkSurfaceVariant,
    );
  }

  // ---------------------------------------------------------------------
  // Shared builder — every component theme lives here ONCE, fed by colors
  // that differ between light/dark.
  // ---------------------------------------------------------------------
  static ThemeData _build({
    required ColorScheme colorScheme,
    required Brightness brightness,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color dividerColor,
    required Color onBackground,
    required Color mutedText,
    required Color inputFill,
  }) {
    final base = brightness == Brightness.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: scaffoldBackground,
      cardColor: cardColor,
      dividerColor: dividerColor,
      splashColor: AppColors.primary.withOpacity(0.1),
      highlightColor: AppColors.primary.withOpacity(0.05),

      textTheme: base.textTheme.apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        foregroundColor: onBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: onBackground,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
          side: BorderSide(color: dividerColor),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.4),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radius),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: TextStyle(color: mutedText),
        labelStyle: TextStyle(color: mutedText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(AppColors.onPrimary),
        side: BorderSide(color: dividerColor, width: 1.4),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : mutedText,
        ),
        trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
              ? AppColors.primary.withOpacity(0.4)
              : dividerColor,
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: mutedText,
        indicatorColor: AppColors.primary,
      ),

      dividerTheme: DividerThemeData(color: dividerColor, thickness: 1),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: mutedText,
        type: BottomNavigationBarType.fixed,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: onBackground,
        contentTextStyle: TextStyle(color: scaffoldBackground),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
      ),
    );
  }
}