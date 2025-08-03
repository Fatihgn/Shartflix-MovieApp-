part of '../profile_view.dart';

/// A custom app bar for the profile view, including a language switcher and a title.
class CustomProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70.w,
      leading: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          margin: EdgeInsets.only(left: 15.w),
          decoration: BoxDecoration(
            color: context.whiteContainer,
            border: Border.all(
              color: context.borderColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(30.r),
          ),

          /// This widget allows the user to switch the app's language.
          /// When tapped, it updates the language to English.
          /// We can replace the language switch logic with your own implementation.
          child: InkWell(
            onTap: () async {
              await FirebaseAnalytics.instance.logEvent(
                name: 'change_language',
                parameters: {'language': 'en'},
              );
              ProductLocalization.updateLanguage(
                context: context,
                value: Locales.en,
              );
              /*
              await context.read<CacheService>().clearUserData();
              context.go(RouteName.login);*/
            },
            child: Center(
              child: Icon(
                Icons.language,
                color: context.textColor,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        LocaleKeys.profile_title,
        style: TextStyle(
          fontSize: ProjectFonts.normal.value.sp,
          fontWeight: FontWeight.w500,
          color: context.textColor,
        ),
      ).tr(),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          width: 115.w,
          height: 33.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
              backgroundColor: context.primaryColor,
            ),
            onPressed: () {
              PremiumBottomSheet(context);
            },
            child: Row(
              children: [
                Assets.images.gem.image(
                  package: 'gen',
                  width: 20.w,
                ),
                Gap(7.w),
                Text(
                  LocaleKeys.profile_premium.tr(),
                  style: TextStyle(
                    fontSize: ProjectFonts.small.value.sp,
                    fontWeight: FontWeight.w500,
                    color: context.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
