part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess(this.movies);
  final List<MovieModel> movies;

  @override
  List<Object> get props => [movies];
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
