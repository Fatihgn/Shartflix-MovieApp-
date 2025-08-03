part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess(this.user);
  final UserModel user;

  @override
  List<Object> get props => [user];
}

final class LoginFailure extends LoginState {
  const LoginFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
