import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/utility/extension/show_snackbar.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/core/widget/text_field/custom_text_field.dart';
import 'package:Shartflix/feature/login/view/login_view.dart';
import 'package:Shartflix/feature/login/view_model/bloc/login_bloc.dart';
import 'package:Shartflix/feature/register/view/mixin/register_view_mixin.dart';
import 'package:Shartflix/feature/register/view_model/bloc/register_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(context.read<AuthService>()),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.go(RouteName.uploadPhoto);
          } else if (state is RegisterFailure) {
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
                        Gap(150.h),
                        Text(
                          LocaleKeys.register_title,
                          style: TextStyle(
                            fontSize: ProjectFonts.large.value.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textColor,
                          ),
                        ).tr(),
                        Gap(8.h),
                        Text(
                          LocaleKeys.register_subtitle,
                          style: TextStyle(
                            fontSize: ProjectFonts.medium.value.sp,
                            fontWeight: FontWeight.w400,
                            color: context.textColor,
                          ),
                        ).tr(),
                        Gap(40.h),
                        CustomTextField(
                          controller: usernameController,
                          hintText: LocaleKeys.register_name.tr(),
                          prefixIcon: Assets.images.user.image(
                            package: 'gen',
                          ),
                        ),
                        Gap(14.h),
                        CustomTextField(
                          controller: emailController,
                          hintText: LocaleKeys.register_mail.tr(),
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
                        Gap(14.h),
                        ValueListenableBuilder<bool>(
                          valueListenable: isObscureNotifier,
                          builder: (context, isObscure, child) {
                            return CustomTextField(
                              isObscure: isObscureNotifier.value,
                              controller: confirmPasswordController,
                              hintText: LocaleKeys.register_confirmPassword
                                  .tr(),
                              prefixIcon: Assets.images.unlock.image(
                                package: 'gen',
                              ),
                            );
                          },
                        ),
                        Gap(16.h),
                        Text.rich(
                          TextSpan(
                            text: LocaleKeys.register_userRead.tr(),
                            style: TextStyle(
                              fontSize: ProjectFonts.small.value.sp,
                              color: context.hintTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${LocaleKeys.register_userRead2.tr()}',
                                style: TextStyle(
                                  color: context.textColor,
                                  fontSize: ProjectFonts.small.value.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: context.textColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ${LocaleKeys.register_userRead3.tr()}',
                                style: TextStyle(
                                  color: context.hintTextColor,
                                  fontSize: ProjectFonts.small.value.sp,

                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(38.h),

                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              final check = checkValues();
                              if (check) {
                                return;
                              }
                              context.read<RegisterBloc>().add(
                                Register(
                                  emailController.text.trim(),
                                  usernameController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                            },
                            child: Text(
                              LocaleKeys.register_registerButton.tr(),
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
                              LocaleKeys.register_loginText.tr(),
                              style: TextStyle(
                                fontSize: ProjectFonts.small.value.sp,
                                fontWeight: FontWeight.w400,
                                color: context.hintTextColor,
                              ),
                            ),
                            Gap(5.w),
                            InkWell(
                              onTap: () {
                                context.go(RouteName.login);
                              },
                              child: Text(
                                LocaleKeys.register_loginButton.tr(),
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
                              width: 100,
                              height: 100,
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
