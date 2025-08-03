import 'package:Shartflix/core/utility/constants/enums/project_radius.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class NormalText extends StatelessWidget {
  const NormalText({
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    super.key,
  });

  /// title text
  final String title;

  /// font size
  final double fontSize;

  /// font weight
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: context.textColor,
      ),
    );
  }
}
