import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FoodAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RSizedBox(height: 40),
        CustomAppBar(
          automaticallyImplyLeading: true,
          title: AppText.foodRecommendation.tr(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(96);
}
