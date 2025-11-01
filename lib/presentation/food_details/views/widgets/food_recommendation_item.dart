import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodRecommendationItem extends StatelessWidget {
  const FoodRecommendationItem({super.key, required this.mealData, this.onTap});
  final MealEntity mealData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: RSizedBox(
        height: 160.r,
        width: 163.r,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              width: 1.r,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                blurStyle: BlurStyle.outer,
                blurRadius: 8.r,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: BlurredContainer(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(20.r),
                  halfTheBlurValue: 2.5,
                  blurColor: theme.colorScheme.secondaryFixed.withValues(
                    alpha: 0.1,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: mealData.thumbnail != null
                        ? CachedNetworkImage(
                            imageUrl: mealData.thumbnail!,
                            color: theme.colorScheme.secondaryFixed.withValues(
                              alpha: 0.5,
                            ),
                            colorBlendMode: BlendMode.dstOut,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            color: theme.colorScheme.secondaryFixed.withValues(
                              alpha: 0.5,
                            ),
                            colorBlendMode: BlendMode.dstOut,
                            AppImages.foodNotFound,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mealData.name ?? AppText.notProvided.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const RSizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
