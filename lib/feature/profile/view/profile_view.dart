import 'dart:developer';
import 'dart:io';

import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/init/language/product_localization.dart';
import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/service/movie_service.dart';
import 'package:Shartflix/core/utility/constants/enums/locales.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/feature/profile/view/mixin/profile_view_mixin.dart';
import 'package:Shartflix/feature/profile/view/widget/premium_bottom_sheet/premium_bottom_sheet.dart';
import 'package:Shartflix/feature/profile/view_model/bloc/profile_bloc.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:go_router/go_router.dart';

part 'widget/custom_profile_app_bar.dart';
part 'widget/user_info.dart';
part 'widget/build_movie_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomProfileAppBar(),
          body: Padding(
            padding: ProjectPadding.profilePadding(),
            child: FutureBuilder<UserModel>(
              future: userDetailsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    state is ProfileLoading) {
                  return Center(
                    child: Assets.lottie.movie.lottie(
                      package: 'gen',
                      width: 130,
                      height: 130,
                    ),
                  );
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(20.h),
                        UserInfo(user: user),
                        Gap(40.h),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.profile_favorites.tr(),
                              style: TextStyle(
                                fontSize: ProjectFonts.medium.value.sp,
                                fontWeight: FontWeight.w700,
                                color: context.textColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(20.h),
                        if (state is ProfileSuccess)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.movies.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.6,
                                ),
                            itemBuilder: (context, index) {
                              final movie = state.movies[index];
                              return BuildMovieCard(movie: movie);
                            },
                          ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Kullanıcı verisi bulunamadı.'),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
