import 'dart:developer';
import 'dart:io';

import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/utility/constants/enums/project_fonts.dart';
import 'package:Shartflix/core/utility/constants/enums/project_radius.dart';
import 'package:Shartflix/core/utility/extension/color_scheme_extension.dart';
import 'package:Shartflix/core/utility/extension/show_snackbar.dart';
import 'package:Shartflix/core/widget/padding/project_padding.dart';
import 'package:Shartflix/feature/login/view_model/bloc/login_bloc.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:Shartflix/product/init/language/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gen/gen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'widget/add_photo.dart';
part 'widget/add_photo_mixin.dart';

/// The UploadPhotoView allows users to upload a profile photo.
/// It provides a user interface for selecting and cropping an image,
class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is UploadPhotoFailure) {
          context.showErrorSnackBar(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.backGroundColor,
          appBar: AppBar(
            leadingWidth: 70.w,
            leading: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                margin: EdgeInsets.only(left: 15.w),
                decoration: BoxDecoration(
                  color: context.whiteContainer,
                  border: Border.all(
                    color: context.borderColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: InkWell(
                  onTap: () async {
                    context.pop();
                  },
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: context.textColor,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              LocaleKeys.upload_photo_title.tr(),
              style: TextStyle(
                fontSize: ProjectFonts.normal.value.sp,
                fontWeight: FontWeight.w400,
                color: context.textColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: ProjectPadding.loginPadding(),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Gap(50.h),
                      Text(
                        LocaleKeys.upload_photo_subtitle.tr(),
                        style: TextStyle(
                          fontSize: ProjectFonts.large.value.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                      ),
                      Gap(10.h),
                      Text(
                        LocaleKeys.upload_photo_explain.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ProjectFonts.medium.value.sp,
                          fontWeight: FontWeight.w400,
                          color: context.textColor,
                        ),
                      ),
                      Gap(47.h),
                      const AddPhoto(),
                      Gap(250.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (state is UploadPhotoInitial) {
                              log('No photo selected');
                              context.showErrorSnackBar(
                                message: LocaleKeys.general_dialog_error_message
                                    .tr(),
                                context: context,
                              );
                              return;
                            }
                            if (state is UploadPhotoLoading) {
                              log('Photo is already being uploaded');
                              return;
                            }
                            if (state is UploadPhotoSuccess &&
                                state.filePath != null) {
                              context.read<UploadPhotoBloc>().add(
                                UploadPhoto(state.filePath!),
                              );
                              context.go(RouteName.profile);
                            } else {
                              log('Photo upload failed');
                              context.showErrorSnackBar(
                                message: LocaleKeys.general_dialog_error_message
                                    .tr(),
                                context: context,
                              );
                            }
                          },
                          child: Text(LocaleKeys.upload_photo_button.tr()),
                        ),
                      ),
                    ],
                  ),
                  if (state is LoginLoading)
                    Positioned.fill(
                      child: ColoredBox(
                        color: Colors.black26,
                        child: Center(
                          child: Assets.lottie.movie.lottie(
                            package: 'gen',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
