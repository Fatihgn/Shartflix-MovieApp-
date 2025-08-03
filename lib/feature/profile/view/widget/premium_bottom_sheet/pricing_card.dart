import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/constants/enums/project_radius.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PricingCard extends StatelessWidget {
  const PricingCard({
    required this.sale,
    required this.oldJeton,
    required this.jeton,
    required this.price,
    required this.color,
    super.key,
  });

  final String sale;
  final String oldJeton;
  final String jeton;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.w,
      height: 230.h,
      child: Stack(
        children: [
          Positioned(
            top: 10.h,
            left: 0.w,
            right: 0.w,
            child: Container(
              height: 210.h,
              width: 110.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color,
                    context.primaryColor,
                  ],
                ),
                border: Border.all(
                  color: context.borderColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(
                  ProjectRadius.normal.value,
                ),
              ),
              child: Column(
                children: [
                  Gap(45.h),
                  Text(
                    oldJeton,
                    style: TextStyle(
                      fontSize: ProjectFonts.normal.value.sp,
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: context.textColor,
                    ),
                  ),
                  Text(
                    jeton,
                    style: TextStyle(
                      fontSize: ProjectFonts.xxLarge.value.sp,
                      fontWeight: FontWeight.w900,
                      color: context.textColor,
                      fontFamily: 'Montserat',
                    ),
                  ),
                  Text(
                    LocaleKeys.premium_token,
                    style: TextStyle(
                      fontSize: ProjectFonts.normal.value.sp,
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ),
                  ).tr(),
                  Gap(25.h),
                  Container(
                    width: 80.w,
                    height: 0.5.h,
                    color: context.hintTextColor,
                  ),
                  Gap(10.h),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: ProjectFonts.normal.value.sp,
                      fontWeight: FontWeight.w900,
                      color: context.textColor,
                      fontFamily: 'Montserat',
                    ),
                  ),
                  Text(
                    LocaleKeys.premium_perWeek,
                    style: TextStyle(
                      fontSize: ProjectFonts.small.value.sp,
                      fontWeight: FontWeight.w400,
                      color: context.textColor,
                    ),
                  ).tr(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.h,
            left: 25.w,
            right: 25.w,
            child: Container(
              height: 25.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    color,
                  ],
                  focal: Alignment.center,
                  focalRadius: 3,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0.01,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  sale,
                  style: TextStyle(
                    fontSize: ProjectFonts.small.value.sp,
                    fontWeight: FontWeight.w400,
                    color: context.textColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
