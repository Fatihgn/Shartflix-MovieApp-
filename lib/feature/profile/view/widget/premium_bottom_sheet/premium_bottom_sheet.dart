import 'dart:ui';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/feature/profile/view/widget/premium_bottom_sheet/bonus_card.dart';
import 'package:Shartflix/feature/profile/view/widget/premium_bottom_sheet/pricing_card.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';

/// Displays a bottom sheet with premium features and pricing options.
/// This bottom sheet includes a bonus card, pricing cards, and a button to purchase tokens.
void PremiumBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,

    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return SizedBox(
        height: 650.h,
        width: double.infinity,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: ColoredBox(
              color: context.backGroundTwoColor,
              child: Stack(
                children: [
                  Positioned(
                    top: 600.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 400.w,
                      height: 400.h,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 0.7,
                          colors: [
                            context.primaryColor.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          tileMode: TileMode.decal,
                          focal: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 400.w,
                      height: 400.h,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 0.7,
                          colors: [
                            context.primaryColor.withOpacity(0.5),
                            Colors.transparent,
                          ],
                          tileMode: TileMode.decal,
                          focal: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const ProjectPadding.symmetricMedium(),
                      child: Column(
                        children: [
                          Gap(10.h),
                          Text(
                            LocaleKeys.premium_title,
                            style: TextStyle(
                              fontSize: ProjectFonts.extraLarge.value.sp,
                              color: context.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ).tr(),
                          Gap(5.h),
                          SizedBox(
                            width: 250.w,
                            child: Text(
                              LocaleKeys.premium_subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ProjectFonts.small.value.sp,
                                color: context.textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr(),
                          ),
                          Gap(12.h),
                          const BonusCard(),
                          Gap(20.h),
                          Text(
                            LocaleKeys.premium_lock,
                            style: TextStyle(
                              fontSize: ProjectFonts.normal.value.sp,
                              fontWeight: FontWeight.w500,
                              color: context.textColor,
                            ),
                          ).tr(),
                          Gap(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PricingCard(
                                price: '₺99,99',
                                sale: '+10%',
                                jeton: '330',
                                oldJeton: '200',
                                color: context.secondaryColor,
                              ),
                              PricingCard(
                                price: '₺799,99',
                                sale: '+70%',
                                jeton: '3.375',
                                oldJeton: '2.000',
                                color: context.tertiaryColor,
                              ),
                              PricingCard(
                                price: '₺399,99',
                                sale: '+35%',
                                jeton: '1.350',
                                oldJeton: '1.000',
                                color: context.secondaryColor,
                              ),
                            ],
                          ),
                          Gap(5.h),
                          SizedBox(
                            width: double.infinity,
                            height: 53.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                LocaleKeys.premium_allTokens,
                                style: TextStyle(
                                  fontSize: ProjectFonts.normal.value.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.textColor,
                                ),
                              ).tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
