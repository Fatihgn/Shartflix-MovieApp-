import 'dart:ui' as ui;

import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/feature/home/view/mixin/home_view_mixin.dart';
import 'package:Shartflix/feature/home/view_model/bloc/home_bloc.dart';
import 'package:Shartflix/feature/profile/view_model/bloc/profile_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';

part 'widget/description_for_more.dart';
part 'widget/like_button.dart';

/// The main view for the home screen, displaying a list of movies.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state is HomeLoading;
        final isHasMoreLoading = state is HomeSuccess && state.hasMore;
        final movies = state is HomeSuccess
            ? setSecureUrls(state.model.movies)
            : <MovieModel>[];

        return Scaffold(
          backgroundColor: context.backGroundColor,
          body: Stack(
            children: [
              if (isLoading && movies.isEmpty)
                Center(
                  child: Assets.lottie.movie.lottie(
                    package: 'gen',
                    width: 130,
                    height: 130,
                  ),
                )
              else
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(const MovieListEvent(1));
                  },
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        movies.length + (isLoading || isHasMoreLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == movies.length && isHasMoreLoading) {
                        return Center(
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
                        );
                      }
                      if (index >= movies.length) {
                        return const SizedBox.shrink();
                      }

                      final movie = movies[index];
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            movie.posterUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const ColoredBox(
                                  color: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black87],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.7, 1.0],
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 10.h,
                            left: 10.w,
                            right: 10.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                LikeButton(movie: movie),
                                Gap(10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.images.logo.image(
                                      package: 'gen',
                                      width: 40.w,
                                      height: 40.h,
                                    ),
                                    Gap(20.w),
                                    SizedBox(
                                      width: 280.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title!,
                                            style: TextStyle(
                                              color: context.textColor,
                                              fontSize:
                                                  ProjectFonts.large.value.sp,
                                              fontWeight: FontWeight.w600,
                                              shadows: const [
                                                Shadow(blurRadius: 10),
                                              ],
                                            ),
                                          ),
                                          // The new widget is called here.
                                          DescriptionForMore(
                                            description: movie.description!,
                                            isExpandedNotifier:
                                                isExpandedNotifier,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
