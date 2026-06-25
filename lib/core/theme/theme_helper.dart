import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pps_soft_task/core/cache/cache_data.dart';



abstract class ThemeHelper {
  static ThemeMode _currentMode = ThemeMode.system;

  // ---------------------------------------------------------------------
  // Read the current state
  // ---------------------------------------------------------------------

  /// The mode the user picked (light/dark/system) — NOT resolved against
  /// the platform, so this can be [ThemeMode.system] even on a dark phone.
  static ThemeMode get currentThemeMode => _currentMode;

  /// Whether the screen is ACTUALLY dark right now. Resolves
  /// [ThemeMode.system] against the real platform brightness, so this is
  /// always accurate regardless of what mode is selected.
  static bool get isDarkMode {
    if (_currentMode == ThemeMode.system) {
      final platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return platformBrightness == Brightness.dark;
    }
    return _currentMode == ThemeMode.dark;
  }

  /// Serialized tag for persistence (SharedPreferences/GetStorage),
  /// e.g. `myStorage.write('theme', ThemeHelper.themeModeTag)`.
  static String get themeModeTag => _themeModeToTag(_currentMode);

  // ---------------------------------------------------------------------
  // Change the theme
  // ---------------------------------------------------------------------

  /// Switches to an explicit mode (light/dark/system).
  static void setThemeMode(ThemeMode mode) {
    _currentMode = mode;
    CacheData.themeMode.set(_themeModeToTag(mode));
    Get.changeThemeMode(mode);
  }

  /// Toggles light <-> dark. If currently on "system", flips to the
  /// opposite of whatever the system is showing right now.
  static void toggleTheme() {
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  // ---------------------------------------------------------------------
  // Resolve the initial mode on app start — same "saved choice, else
  // sensible default" pattern as TranslationService.resolveInitialLocale.
  // Call this ONCE before `runApp`, and feed the result into
  // `GetMaterialApp(themeMode: ...)`.
  // ---------------------------------------------------------------------
  static ThemeMode resolveInitialThemeMode() {
    var savedThemeMode = CacheData.themeMode.value;
    final resolved = savedThemeMode != null
        ? (_tagToThemeMode(savedThemeMode) ?? ThemeMode.system)
        : ThemeMode.system;
    _currentMode = resolved;
    return resolved;
  }

  // ---------------------------------------------------------------------
  // Tag <-> ThemeMode conversion
  // ---------------------------------------------------------------------
  static ThemeMode? _tagToThemeMode(String tag) {
    switch (tag) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  static String _themeModeToTag(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}