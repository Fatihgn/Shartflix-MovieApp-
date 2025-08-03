import 'dart:developer';
import 'dart:math';

import 'package:Shartflix/core/model/movie_list.dart';
import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/service/movie_service.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._HomeService) : super(HomeInitial()) {
    on<MovieListEvent>(_MovieList);
    on<SetFavoriteEvent>(_SetFavorite);
  }
  final MovieService _HomeService;

  /// Fetches the movie list based on the event page.
  Future<void> _MovieList(
    MovieListEvent event,
    Emitter<HomeState> emit,
  ) async {
    /// Check if the current state is loading or has more data to load.
    if (state is HomeLoading) return;
    if (state is HomeSuccess && (state as HomeSuccess).hasMore) return;

    /// Emit HomeLoading state if the event page is 1, otherwise emit HomeSuccess with hasMore set to true.
    if (event.page == 1) {
      emit(HomeLoading());
    } else {
      emit(
        HomeSuccess(
          (state as HomeSuccess).model,
          true,
        ),
      );
    }

    final currentMovies = state is HomeSuccess
        ? [...(state as HomeSuccess).model.movies]
        : <MovieModel>[];

    final response = await _HomeService.movieList(event.page);
    switch (response) {
      case Success(data: final data):
        final newMovies = [...currentMovies, ...data.movies];

        final updatedMovieList = MovieList(
          movies: newMovies,
          pagination: data.pagination,
        );
        emit(HomeSuccess(updatedMovieList, false));
      case Failure(error: final apiError):
        emit(HomeFailure(apiError.message));
    }
  }

  /// Toggles the favorite status of a movie based on the event ID.
  Future<void> _SetFavorite(
    SetFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeSuccess) return;

    /// Check if the movie is already in the list.
    final currentState = state as HomeSuccess;
    final movies = [...currentState.model.movies];

    /// If the movie is not found, return early.
    final movieIndex = movies.indexWhere((movie) => movie.id == event.id);
    if (movieIndex == -1) return;

    /// Toggle the favorite status of the movie and update the list.
    final updated = movies[movieIndex].copyWith(
      isFavorite: !(movies[movieIndex].isFavorite ?? false),
    );
    movies[movieIndex] = updated;

    final response = await _HomeService.setFavorite(event.id);

    switch (response) {
      case Success(data: final data):
        final newMovieList = MovieList(
          movies: movies,
          pagination: currentState.model.pagination,
        );
        emit(HomeSuccess(newMovieList, false));
      case Failure(error: final apiError):
        final newMovieList = MovieList(
          movies: movies,
          pagination: currentState.model.pagination,
        );
        emit(HomeSuccess(newMovieList, false));
    }
  }
}
