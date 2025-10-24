import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/utils/common_widgets/circular_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularSvgIcon(iconPath: AppIcons.facebook),
        RSizedBox(width: 16),
        CircularSvgIcon(iconPath: AppIcons.google),
        RSizedBox(width: 16),
        CircularSvgIcon(iconPath: AppIcons.apple),
      ],
    );
  }
}
