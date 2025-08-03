import 'package:Shartflix/core/init/theme/custom_color_scheme.dart';
import 'package:Shartflix/core/init/theme/custom_theme.dart';
import 'package:flutter/material.dart';

/// Custom light theme for project design
/// In the future we can add custom dark theme from here
final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    colorScheme: CustomColorScheme.darkColorScheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
  );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData();

  @override
  final ElevatedButtonThemeData elevatedButtonThemeData =
      const ElevatedButtonThemeData();

  @override
  InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme();
}
