part of '../upload_photo_view.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> with AddPhotoMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            final file = await pickAndUploadImage();

            if (file == null) {
              return;
            }
            context.read<UploadPhotoBloc>().add(
              SavePhoto(file),
            );
          },
          child: Container(
            width: 170.w,
            height: 170.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: context.borderColor,
              ),
              color: context.whiteContainer,
              borderRadius: BorderRadius.all(
                Radius.circular(ProjectRadius.large.value),
              ),
            ),
            child: state is UploadPhotoSuccess
                ? Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(ProjectRadius.large.value),
                        ),
                        child: state.filePath == null
                            ? Icon(
                                Icons.add,
                                color: context.hintTextColor,
                                size: 50.sp,
                              )
                            : Image.file(
                                File(state.filePath!),
                                fit: BoxFit.cover,
                              ),
                      ),

                      if (state.filePath != null)
                        const Positioned(
                          top: -7,
                          right: -7,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 28,
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  )
                : Icon(
                    Icons.add,
                    color: context.hintTextColor,
                    size: 50.sp,
                  ),
          ),
        );
      },
    );
  }
}
