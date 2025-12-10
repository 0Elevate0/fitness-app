import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/utils/common_widgets/custom_image_container.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.mealData, this.onTap});

  final MealEntity mealData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: CustomImageContainer(
          widget: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl: mealData.thumbnail ?? "",
              errorWidget: (context, url, error) =>
                  Image.asset(AppImages.foodNotFound, fit: BoxFit.cover),
              placeholder: (context, url) => ShimmerEffect(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
              ),
              fit: BoxFit.cover,
            ),
          ),
          title: mealData.name ?? '',
        ),
      ),
    );
  }
}
