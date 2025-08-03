part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class Login extends LoginEvent {
  const Login(this.username, this.password);
  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}
