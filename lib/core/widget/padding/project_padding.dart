import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Project general padding items
final class ProjectPadding extends EdgeInsets {
  const ProjectPadding._() : super.all(0);

  /// All Padding
  ///

  /// [ProjectPadding.allSmall] is 8
  const ProjectPadding.allSmall() : super.all(8);

  /// [ProjectPadding.allMedium] is 16
  const ProjectPadding.allMedium() : super.all(16);

  /// [ProjectPadding.allNormal] is 20
  const ProjectPadding.allNormal() : super.all(20);

  /// [ProjectPadding.allLarge] is 32
  const ProjectPadding.allLarge() : super.all(32);

  /// Symmetric
  /// [ProjectPadding.symmetricSmall] is 8
  const ProjectPadding.symmetricSmall()
    : super.symmetric(horizontal: 8, vertical: 8);

  /// [ProjectPadding.symmetricMedium] is 16
  const ProjectPadding.symmetricMedium()
    : super.symmetric(horizontal: 16, vertical: 16);

  /// Horizontal
  /// [ProjectPadding.loginPadding] is 39
  ProjectPadding.loginPadding() : super.symmetric(horizontal: 39.w);

  /// Horizontal
  /// [ProjectPadding.profilePadding] is 25
  ProjectPadding.profilePadding() : super.symmetric(horizontal: 25.w);
}
