import 'dart:developer';
import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/feature/home/view/home_view.dart';
import 'package:Shartflix/feature/home/view_model/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeViewMixin on State<HomeView> {
  final PageController pageController = PageController();
  late final ValueNotifier<bool> isExpandedNotifier;

  @override
  void initState() {
    super.initState();

    /// Initialize the list of ValueNotifiers for expanded states.
    isExpandedNotifier = ValueNotifier<bool>(false);

    pageController.addListener(() {
      // Reset the expanded state when the user scrolls.
      isExpandedNotifier.value = false;
    });

    // Initialize the HomeBloc with the first page of movies.
    context.read<HomeBloc>().add(const MovieListEvent(1));

    // Listen to the PageController to fetch more movies when the user scrolls to the end.
    pageController.addListener(() {
      final blocState = context.read<HomeBloc>().state;

      /// Check if the current page is the last page and if there are no more movies to load.
      if (blocState is HomeSuccess &&
          blocState.model.pagination!.maxPage ==
              blocState.model.pagination?.currentPage) {
        return;
      }

      /// Check if the current page is the last page and if there are more movies to load.
      if (blocState is HomeSuccess &&
          pageController.page! >= blocState.model.movies.length - 1 &&
          !blocState.hasMore) {
        log('Fetching next page...');
        final movies = context.read<HomeBloc>().add(
          MovieListEvent(
            (blocState.model.pagination?.currentPage ?? 0) + 1,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    isExpandedNotifier.dispose();
    pageController.dispose();
    super.dispose();
  }

  /// Sets secure URLs for movie posters by replacing 'http://' with 'https://'.
  List<MovieModel> setSecureUrls(List<MovieModel> movies) {
    return movies.map((movie) {
      var updatedPosterUrl = movie.posterUrl;
      if (updatedPosterUrl != null && updatedPosterUrl.startsWith('http://')) {
        updatedPosterUrl = updatedPosterUrl.replaceAll('http://', 'https://');
        return movie.copyWith(posterUrl: updatedPosterUrl);
      }
      return movie;
    }).toList();
  }
}
