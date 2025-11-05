import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileResetPasswordAppBar extends StatelessWidget {
  const ProfileResetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      automaticallyImplyLeading: true,
      isTitleNotString: true,
      titleWidget: Padding(
        padding: REdgeInsetsDirectional.only(end: 24),
        child: Image.asset(
          AppImages.superFitness,
          height: 70.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
