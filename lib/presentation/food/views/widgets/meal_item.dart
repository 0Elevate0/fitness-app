import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/utils/common_widgets/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.mealData, this.onTap});

  final MealEntity mealData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: CustomImageContainer(
          widget: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: mealData.thumbnail != null
                    ? CachedNetworkImageProvider(mealData.thumbnail ?? "")
                    : const AssetImage(AppImages.foodNotFound),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: mealData.name ?? '',
        ),
      ),
    );
  }
}
