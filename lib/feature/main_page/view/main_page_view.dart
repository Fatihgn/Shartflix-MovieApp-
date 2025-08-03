import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/feature/profile/view_model/bloc/profile_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';
import 'package:go_router/go_router.dart';

/// The main view for the main page, which includes a bottom navigation bar and a navigation shell.
class MainPageView extends StatelessWidget {
  const MainPageView({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selectedColor = context.primaryColor;
    final unselectedColor = context.textColor;
    final backgroundColor = context.backGroundColor;
    return Scaffold(
      backgroundColor: context.backGroundColor,
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 80.h,
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(14.w),
            _buildNavItem(
              context,
              icon: Assets.images.home.image(
                package: 'gen',
                width: 24.sp,
              ),
              label: LocaleKeys.bottom_home.tr(),
              index: 0,
              navigationShell: navigationShell,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            _buildNavItem(
              context,
              icon: Assets.images.person.image(
                package: 'gen',
                width: 24.sp,
              ),
              label: LocaleKeys.bottom_profile.tr(),
              index: 1,
              navigationShell: navigationShell,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            Gap(15.w),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required Image icon,
    required String label,
    required int index,
    required StatefulNavigationShell navigationShell,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    final isSelected = navigationShell.currentIndex == index;

    return InkWell(
      onTap: () {
        if (index == 1) {
          // context.read<ProfileBloc>().add(const Favorites());
        }
        navigationShell.goBranch(
          index,
          initialLocation: isSelected,
        );
      },
      child: Container(
        width: 125.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: context.backGroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.fromBorderSide(
            BorderSide(color: isSelected ? selectedColor : context.borderColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: icon,
            ),
            Gap(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: ProjectFonts.small.value.sp,
                fontWeight: FontWeight.w500,
                color: unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
