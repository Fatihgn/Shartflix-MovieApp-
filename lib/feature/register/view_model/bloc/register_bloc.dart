import 'dart:developer';

import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._RegisterService) : super(RegisterInitial()) {
    on<Register>(_Register);
  }
  final AuthService _RegisterService;

  Future<void> _Register(Register event, Emitter<RegisterState> emit) async {
    if (state is RegisterLoading) return;
    emit(RegisterLoading());

    final response = await _RegisterService.register(
      event.email,
      event.username,
      event.password,
    );

    switch (response) {
      case Success(data: final data):
        emit(RegisterSuccess(data));
      case Failure(error: final apiError):
        emit(RegisterFailure(apiError.message));
    }
  }
}
