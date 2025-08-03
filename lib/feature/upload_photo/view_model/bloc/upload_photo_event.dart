part of 'upload_photo_bloc.dart';

sealed class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();

  @override
  List<Object> get props => [];
}

final class UploadPhoto extends UploadPhotoEvent {
  const UploadPhoto(this.file);
  final String file;

  @override
  List<Object> get props => [file];
}

final class SavePhoto extends UploadPhotoEvent {
  const SavePhoto(this.photoUrl);
  final String photoUrl;

  @override
  List<Object> get props => [photoUrl];
}
