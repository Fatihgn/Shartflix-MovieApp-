import 'dart:developer';

import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._LoginService) : super(LoginInitial()) {
    on<Login>(_login);
  }
  final AuthService _LoginService;

  Future<void> _login(Login event, Emitter<LoginState> emit) async {
    if (state is LoginLoading) return;
    emit(LoginLoading());

    final response = await _LoginService.login(
      event.username,
      event.password,
    );

    switch (response) {
      case Success(data: final data):
        emit(LoginSuccess(data));
      case Failure(error: final apiError):
        emit(LoginFailure(apiError.message));
    }
  }
}
