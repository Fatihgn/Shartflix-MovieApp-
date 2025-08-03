part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class MovieListEvent extends HomeEvent {
  const MovieListEvent(this.page);
  final int page;

  @override
  List<Object> get props => [page];
}

final class SetFavoriteEvent extends HomeEvent {
  const SetFavoriteEvent(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}
