import 'package:Shartflix/core/utility/extension/show_snackbar.dart';
import 'package:Shartflix/feature/login/view/login_view.dart';
import 'package:Shartflix/feature/register/view/register_view.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';

mixin RegisterViewMixin on State<RegisterView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool checkValues() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      context.showErrorSnackBar(
        message: LocaleKeys.register_emptyFields.tr(),
        context: context,
      );
      return true;
    } else if (passwordController.text != confirmPasswordController.text) {
      context.showErrorSnackBar(
        message: LocaleKeys.register_passwordMismatch.tr(),
        context: context,
      );
      return true;
    } else {
      return false;
    }
  }

  late final ValueNotifier<bool> isObscureNotifier;

  @override
  void initState() {
    super.initState();
    isObscureNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isObscureNotifier.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
