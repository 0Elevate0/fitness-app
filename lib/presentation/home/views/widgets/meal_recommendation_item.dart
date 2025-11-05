import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealRecommendationItem extends StatelessWidget {
  const MealRecommendationItem({
    super.key,
    required this.mealCategoryData,
    required this.categories,
  });

  final MealCategoryEntity mealCategoryData;
  final List<MealCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.food,
          arguments: MealsArgument(
            categories: categories,
            selectedCategory: mealCategoryData,
          ),
        );
      },
      child: Container(
        width: 104.r,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          image: DecorationImage(
            image: mealCategoryData.strCategoryThumb != null
                ? CachedNetworkImageProvider(
                    mealCategoryData.strCategoryThumb ?? "",
                  )
                : const AssetImage(AppImages.notFound),
            fit: BoxFit.cover,
          ),
        ),
        child: RSizedBox(
          height: 30,
          width: ScreenUtil().screenWidth,
          child: BlurredContainer(
            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 4),
            blurColor: theme.colorScheme.secondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20.r),
            halfTheBlurValue: 5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                mealCategoryData.strCategory ?? AppText.notProvided.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
