import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';

/// A widget that displays a bonus card with premium features.
class BonusCard extends StatelessWidget {
  const BonusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 170.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.textColor.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const ProjectPadding.allMedium(),
        child: Column(
          children: [
            Text(
              LocaleKeys.premium_bonus,
              style: TextStyle(
                fontSize: ProjectFonts.normal.value.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ).tr(),
            Gap(14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBonusItem(
                  imageWidget: Assets.images.premium.image(
                    package: 'gen',
                    width: 50.w,
                  ),
                  labelText: LocaleKeys.premium_account,
                ),
                _buildBonusItem(
                  imageWidget: Assets.images.match.image(
                    package: 'gen',
                    width: 50.w,
                  ),
                  labelText: LocaleKeys.premium_match,
                ),
                _buildBonusItem(
                  imageWidget: Assets.images.recom.image(
                    package: 'gen',
                    width: 50.w,
                  ),
                  labelText: LocaleKeys.premium_recommendation,
                ),
                _buildBonusItem(
                  imageWidget: Assets.images.like.image(
                    package: 'gen',
                    width: 50.w,
                  ),
                  labelText: LocaleKeys.premium_like,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBonusItem({
  required Widget imageWidget,
  required String labelText,
}) {
  return SizedBox(
    width: 75.w,
    child: Column(
      children: [
        imageWidget,
        Gap(12.h),
        Text(
          labelText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ProjectFonts.small.value.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ).tr(),
      ],
    ),
  );
}

// ...
