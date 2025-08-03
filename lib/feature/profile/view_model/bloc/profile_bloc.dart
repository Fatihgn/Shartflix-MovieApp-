import 'dart:developer';

import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/service/movie_service.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

/// The ProfileBloc handles events related to the user's profile, such as fetching favorite movies and changing favorites.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._ProfileService) : super(ProfileInitial()) {
    on<Favorites>(_Favorites);
    on<ChangeFavorite>(_ChangeFavorite);
  }
  final MovieService _ProfileService;

  /// Fetches the user's favorite movies and emits the appropriate state.
  Future<void> _Favorites(
    Favorites event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoading) return;
    emit(ProfileLoading());

    final response = await _ProfileService.favorites();
    switch (response) {
      case Success(data: final data):
        emit(ProfileSuccess(data));
      case Failure(error: final apiError):
        emit(ProfileFailure(apiError.message));
    }
  }

  /// Changes the favorite status of a movie and updates the state accordingly.
  Future<void> _ChangeFavorite(
    ChangeFavorite event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileSuccess) {
      final currentState = state as ProfileSuccess;
      final movies = List<MovieModel>.from(currentState.movies);

      final isExist = movies.any((movie) => movie.id == event.movie.id);

      if (isExist) {
        movies.removeWhere((movie) => movie.id == event.movie.id);
      } else {
        final movieToAdd = event.movie.copyWith(isFavorite: true);
        movies.add(movieToAdd);
      }

      emit(ProfileSuccess(movies));
    }
  }
}
