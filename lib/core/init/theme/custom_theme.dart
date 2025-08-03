import 'package:flutter/material.dart';

/// This interface defines the structure for custom themes in the application.
abstract class CustomTheme {
  ThemeData get themeData;

  FloatingActionButtonThemeData get floatingActionButtonThemeData;

  ElevatedButtonThemeData get elevatedButtonThemeData;

  InputDecorationTheme get inputDecorationTheme;
}
