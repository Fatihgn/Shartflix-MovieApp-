import 'package:Shartflix/core/init/theme/custom_color_scheme.dart';
import 'package:Shartflix/core/init/theme/custom_theme.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/constants/enums/project_radius.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom light theme for project design
final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
    useMaterial3: true,
    fontFamily: 'EuclidCircularA',
    colorScheme: CustomColorScheme.lightColorScheme,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
  );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();

  @override
  final ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: ProjectFonts.normal.value.sp,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: CustomColorScheme.lightColorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
          ),
        ),
      );

  @override
  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: CustomColorScheme.lightColorScheme.secondaryContainer,
    hintStyle: TextStyle(
      fontSize: ProjectFonts.small.value.sp,
      fontWeight: FontWeight.w400,
      color: CustomColorScheme.lightColorScheme.onSecondaryContainer,
    ),

    contentPadding: EdgeInsets.symmetric(
      vertical: 15.h,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(ProjectRadius.medium.value),
      borderSide: BorderSide(
        color: CustomColorScheme.lightColorScheme.outline,
      ),
    ),
  );
}
