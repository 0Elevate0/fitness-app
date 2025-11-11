import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/circular_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.r),
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                child: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppText.or.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.r),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const RSizedBox(height: 24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularSvgIcon(iconPath: AppIcons.facebook),
            RSizedBox(width: 16),
            CircularSvgIcon(iconPath: AppIcons.google),
            RSizedBox(width: 16),
            CircularSvgIcon(iconPath: AppIcons.apple),
          ],
        ),
      ],
    );
  }
}
