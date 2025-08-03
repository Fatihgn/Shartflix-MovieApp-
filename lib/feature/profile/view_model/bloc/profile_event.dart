part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class Favorites extends ProfileEvent {
  const Favorites();
}

final class ChangeFavorite extends ProfileEvent {
  const ChangeFavorite(this.movie, this.isFavorite);
  final MovieModel movie;
  final bool isFavorite;
  @override
  List<Object> get props => [movie, isFavorite];
}
