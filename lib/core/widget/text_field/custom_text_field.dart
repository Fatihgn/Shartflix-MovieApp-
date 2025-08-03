import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gen/gen.dart';

/// A custom text field widget with a hint text, controller, and prefix icon.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.onSuffixIconTap,
    this.isObscure = false,
    this.suffixIcon = false,
    super.key,
  });

  final String hintText;

  final TextEditingController controller;

  final Image prefixIcon;

  final bool isObscure;

  final bool suffixIcon;

  final VoidCallback? onSuffixIconTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 6,
            top: 17,
            bottom: 17,
          ),
          child: SizedBox(width: 20, height: 20, child: widget.prefixIcon),
        ),
        suffixIcon: widget.suffixIcon
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 30,
                  top: 17,
                  bottom: 17,
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: InkWell(
                    onTap: widget.onSuffixIconTap,
                    child: widget.isObscure
                        ? Assets.images.hide.image(
                            package: 'gen',
                          )
                        : Icon(
                            Icons.visibility_outlined,
                            color: context.hintTextColor,
                          ),
                  ),
                ),
              )
            : null,
      ),
      style: TextStyle(
        fontSize: ProjectFonts.small.value.sp,
        color: context.textColor,
      ),
    );
  }
}
