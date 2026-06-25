import 'package:flutter/material.dart';

/// THE single source of truth for every color in the app.
///
/// [AppTheme] builds both the light and dark [ThemeData] purely from this
/// class — never hardcode a `Color(0x...)` anywhere else in the app.
abstract class AppColors {
  // ---------------------------------------------------------------------
  // Brand
  // ---------------------------------------------------------------------
  /// The brand color — used as `primary` in BOTH light and dark themes.
  static const Color primary = Color(0xFFFF6B2B);
  static const Color primaryLight = Color(0xFFFF8F5C);
  static const Color primaryDark = Color(0xFFD9501A);

  /// Text/icon color drawn on top of [primary] (e.g. text on a filled
  /// orange button). White works for both light & dark since the orange
  /// is the same brightness in both.
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------
  // Semantic (status) colors — shared across both themes
  // ---------------------------------------------------------------------
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF1976D2);

  // ---------------------------------------------------------------------
  // Light theme surfaces
  // ---------------------------------------------------------------------
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F1F1);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF1A1A1A);
  static const Color lightOnSurfaceMuted = Color(0xFF6B6B6B);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightBorder = Color(0xFFD8D8D8);

  // ---------------------------------------------------------------------
  // Dark theme surfaces
  // ---------------------------------------------------------------------
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2A2A2A);
  static const Color darkOnBackground = Color(0xFFF2F2F2);
  static const Color darkOnSurface = Color(0xFFF2F2F2);
  static const Color darkOnSurfaceMuted = Color(0xFFA3A3A3);
  static const Color darkDivider = Color(0xFF333333);
  static const Color darkBorder = Color(0xFF3A3A3A);
}