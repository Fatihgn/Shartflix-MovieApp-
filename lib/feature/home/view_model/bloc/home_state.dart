part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  const HomeSuccess(this.model, this.hasMore);
  final MovieList model;
  final bool hasMore;

  @override
  List<Object> get props => [model, hasMore];
}

final class HomeFailure extends HomeState {
  const HomeFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
