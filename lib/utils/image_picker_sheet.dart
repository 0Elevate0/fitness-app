import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerSheet {
  static void showImagePickerOptions(
    BuildContext context,
    SmartCoachChatCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => RPadding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppText.camera.tr(),style: const TextStyle(
                color: AppColors.white
              ),),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await ImagePickerHelper.pickImageFromCamera();
                if (pickedFile != null) {
                  cubit.doIntent(SendImageIntent(imagePath: pickedFile));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppText.gallery.tr(),style: const TextStyle(
                  color: AppColors.white
              ),),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (pickedFile != null) {
                  cubit.doIntent(SendImageIntent(imagePath: pickedFile));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
