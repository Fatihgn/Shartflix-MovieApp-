import 'package:flutter/material.dart';

/// This extension provides easy access to color scheme properties in the context of a Flutter application.
extension ColorSchemeExtension on BuildContext {
  /// Background color of the current theme.
  Color get backGroundColor => Theme.of(this).colorScheme.surface;

  /// Background second color of the current theme.
  Color get backGroundTwoColor => Theme.of(this).colorScheme.onSurface;

  /// Primary color of the current theme (RED).
  Color get primaryColor => Theme.of(this).colorScheme.primary;

  /// secondary color of the current theme (DARK RED).
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  /// tertiary color of the current theme (PURPLE).
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;

  /// White color for text.
  Color get textColor => Theme.of(this).colorScheme.onPrimary;

  /// TextField background color. %10opacity.
  Color get whiteContainer => Theme.of(this).colorScheme.secondaryContainer;

  /// Color for the outline of TextFields. %20opacity.
  Color get borderColor => Theme.of(this).colorScheme.outline;

  /// Color for hint text fields.
  Color get hintTextColor => Theme.of(this).colorScheme.onSecondaryContainer;
}
