part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class Register extends RegisterEvent {
  const Register(this.email, this.username, this.password);
  final String email;
  final String username;
  final String password;

  @override
  List<Object> get props => [email, username, password];
}
