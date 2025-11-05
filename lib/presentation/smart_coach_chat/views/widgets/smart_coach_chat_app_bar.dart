import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmartCoachChatAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SmartCoachChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomBackArrow(),

          Text(
            "Smart Coach",
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          SvgPicture.asset(AppIcons.menu, height: 24.h, width: 24.w),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
