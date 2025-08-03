import 'dart:developer';

import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'upload_photo_event.dart';
part 'upload_photo_state.dart';

/// The UploadPhotoBloc handles events related to uploading and saving user photos.
class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  UploadPhotoBloc(this._UploadPhotoService) : super(UploadPhotoInitial()) {
    on<UploadPhoto>(_UploadPhoto);
    on<SavePhoto>(_SavePhoto);
  }
  final AuthService _UploadPhotoService;

  /// Uploads a photo file and emits the appropriate state based on the response.
  Future<void> _UploadPhoto(
    UploadPhoto event,
    Emitter<UploadPhotoState> emit,
  ) async {
    if (state is UploadPhotoLoading) return;

    emit(UploadPhotoLoading());

    final response = await _UploadPhotoService.changePhoto(event.file);

    switch (response) {
      case Success(data: final data):
        emit(UploadPhotoSuccess(data, null));
      case Failure(error: final apiError):
        emit(UploadPhotoFailure(apiError.message));
    }
  }

  /// Saves the uploaded photo path and emits a success state.
  Future<void> _SavePhoto(
    SavePhoto event,
    Emitter<UploadPhotoState> emit,
  ) async {
    if (state is UploadPhotoLoading) return;

    emit(
      UploadPhotoSuccess(null, event.photoUrl),
    );
  }
}
