import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/constants/enums/project_radius.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/utility/extension/show_snackbar.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/core/widget/text_field/custom_text_field.dart';
import 'package:Shartflix/feature/login/view/mixin/login_view_mixin.dart';
import 'package:Shartflix/feature/login/view_model/bloc/login_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';
import 'package:go_router/go_router.dart';
part 'widget/fast_login_button.dart';

/// The main view for the login screen, allowing users to log in with email and password or through social media accounts.
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthService>()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.go(RouteName.home);
          } else if (state is LoginFailure) {
            // Show loading indicator
            context.showErrorSnackBar(
              message: state.message,
              context: context,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.backGroundColor,
            body: Center(
              child: Padding(
                padding: ProjectPadding.loginPadding(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Gap(300.h),
                        Text(
                          LocaleKeys.login_title,
                          style: TextStyle(
                            fontSize: ProjectFonts.large.value.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textColor,
                          ),
                        ).tr(),
                        Gap(8.h),
                        Text(
                          LocaleKeys.login_subtitle,
                          style: TextStyle(
                            fontSize: ProjectFonts.medium.value.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textColor,
                          ),
                        ).tr(),
                        Gap(40.h),
                        CustomTextField(
                          controller: emailController,
                          hintText: LocaleKeys.login_mail.tr(),
                          prefixIcon: Assets.images.message.image(
                            package: 'gen',
                          ),
                        ),
                        Gap(14.h),
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscureNotifier,
                          builder: (context, isObscure, child) {
                            return CustomTextField(
                              controller: passwordController,
                              isObscure: isObscure,
                              suffixIcon: true,
                              hintText: LocaleKeys.register_password.tr(),
                              prefixIcon: Assets.images.message.image(
                                package: 'gen',
                              ),
                              onSuffixIconTap: () {
                                isObscureNotifier.value =
                                    !isObscureNotifier.value;
                              },
                            );
                          },
                        ),
                        Gap(30.h),
                        Row(
                          children: [
                            InkWell(
                              child: Text.rich(
                                TextSpan(
                                  text: LocaleKeys.login_forgotPassword.tr(),
                                  style: TextStyle(
                                    fontSize: ProjectFonts.small.value.sp,
                                    fontWeight: FontWeight.w400,
                                    color: context.textColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: context.textColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(24.h),
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              final check = checkValues();
                              if (check) {
                                return;
                              }
                              context.read<LoginBloc>().add(
                                Login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                            },
                            child: const Text(
                              LocaleKeys.login_loginButton,
                            ).tr(),
                          ),
                        ),
                        Gap(37.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FastLoginButton(
                              icon: Assets.images.google.image(
                                package: 'gen',
                              ),
                            ),
                            Gap(10.w),
                            FastLoginButton(
                              icon: Assets.images.apple.image(
                                package: 'gen',
                              ),
                            ),
                            Gap(10.w),
                            FastLoginButton(
                              icon: Assets.images.facebook.image(
                                package: 'gen',
                              ),
                            ),
                          ],
                        ),
                        Gap(32.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.login_registerText.tr(),
                              style: TextStyle(
                                fontSize: ProjectFonts.small.value.sp,
                                fontWeight: FontWeight.w400,
                                color: context.hintTextColor,
                              ),
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                context.go(RouteName.register);
                              },
                              child: Text(
                                LocaleKeys.login_registerButton.tr(),
                                style: TextStyle(
                                  fontSize: ProjectFonts.small.value.sp,
                                  fontWeight: FontWeight.w600,
                                  color: context.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (state is LoginLoading)
                      Positioned.fill(
                        child: ColoredBox(
                          color: Colors.black26,
                          child: Center(
                            child: Assets.lottie.movie.lottie(
                              package: 'gen',
                              width: 130,
                              height: 130,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
