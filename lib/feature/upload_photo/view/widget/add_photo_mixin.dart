part of '../upload_photo_view.dart';

mixin AddPhotoMixin on State<AddPhoto> {
  Future<String?> pickAndUploadImage() async {
    final picker = ImagePicker();
    final cropper = ImageCropper();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final croppedFile = await cropper.cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Fotoğrafı Düzenle',
            toolbarColor: context.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Fotoğrafı Düzenle',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
      if (croppedFile == null) {
        return null;
      }
      final file = croppedFile.path;
      return file;
    }
    return null;
  }
}
