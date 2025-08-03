import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ShowSnackBar on BuildContext {
  /// Displays a basic snackbar
  void showSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: context.textColor,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  /// Displays a red snackbar indicating error
  void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: context.textColor,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: context.primaryColor,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }
}
