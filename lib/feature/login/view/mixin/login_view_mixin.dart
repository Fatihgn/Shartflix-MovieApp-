import 'package:Shartflix/core/utility/extension/show_snackbar.dart';
import 'package:Shartflix/feature/login/view/login_view.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

/// A mixin for the login view that provides common functionality.
mixin LoginViewMixin on State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final ValueNotifier<bool> isObscureNotifier;

  bool checkValues() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      context.showErrorSnackBar(
        message: LocaleKeys.login_emptyFields.tr(),
        context: context,
      );
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    isObscureNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    isObscureNotifier.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
