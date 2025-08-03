part of '../profile_view.dart';

/// A widget that displays user information, including their profile picture, name, and ID.
class UserInfo extends StatefulWidget {
  const UserInfo({required this.user, super.key});
  final UserModel user;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    log('User Info: ${widget.user.toJson()}');

    return BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is UploadPhotoSuccess) {
        } else if (state is UploadPhotoFailure) {
        } else if (state is UploadPhotoLoading) {
          // Show loading indicator if needed
        } else if (state is UploadPhotoInitial) {
          log('UploadPhotoInitial state');
        } else {
          log('Unhandled state: $state');
        }
      },

      builder: (context, state) {
        return Row(
          children: [
            if (state is UploadPhotoSuccess &&
                state.user?.photoUrl != null &&
                state.user!.photoUrl!.isNotEmpty)
              CircleAvatar(
                radius: 35.w,
                backgroundImage: NetworkImage(state.user!.photoUrl!),
              )
            else if (widget.user.photoUrl != null &&
                widget.user.photoUrl!.isNotEmpty)
              CircleAvatar(
                radius: 35.w,
                backgroundImage: NetworkImage(widget.user.photoUrl!),
              )
            else
              CircleAvatar(
                radius: 35.w,
                child: Assets.images.person.image(
                  package: 'gen',
                ),
              ),
            Gap(20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130.w,
                  child: Text(
                    widget.user.name ?? 'No Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ProjectFonts.normal.value.sp,
                      fontWeight: FontWeight.w500,
                      color: context.textColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    'ID: ${widget.user.id}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ProjectFonts.small.value.sp,
                      fontWeight: FontWeight.w400,
                      color: context.hintTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 120.w,
              height: 36.h,
              child: ElevatedButton(
                onPressed: () {
                  context.push(RouteName.uploadPhoto);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                ),

                child: Text(
                  LocaleKeys.profile_addPhoto.tr(),

                  style: TextStyle(
                    fontSize: ProjectFonts.medium.value.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
