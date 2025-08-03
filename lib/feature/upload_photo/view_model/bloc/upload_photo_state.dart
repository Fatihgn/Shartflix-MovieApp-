part of 'upload_photo_bloc.dart';

sealed class UploadPhotoState extends Equatable {
  const UploadPhotoState();

  @override
  List<Object> get props => [];
}

final class UploadPhotoInitial extends UploadPhotoState {}

final class UploadPhotoLoading extends UploadPhotoState {}

final class UploadPhotoSuccess extends UploadPhotoState {
  const UploadPhotoSuccess(this.user, this.filePath);
  final UserModel? user;
  final String? filePath;

  @override
  List<Object> get props => [user ?? '', filePath ?? ''];
}

final class UploadPhotoFailure extends UploadPhotoState {
  const UploadPhotoFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
