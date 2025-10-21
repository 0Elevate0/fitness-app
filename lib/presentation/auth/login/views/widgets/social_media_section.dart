import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 1.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.r),
                color: Colors.white,
              ),
            ),
            const RSizedBox(width: 20),
            Text(
              AppText.or.tr(),
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
            const RSizedBox(width: 20),
            Container(
              width: 80.w,
              height: 1.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.r),
                color: Colors.white,
              ),
            ),
          ],
        ),
        const RSizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.faceBook),
            const RSizedBox(width: 16),
            SvgPicture.asset(AppIcons.google),
            const RSizedBox(width: 16),
            SvgPicture.asset(AppIcons.apple),
          ],
        ),
      ],
    );
  }
}
