import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_ingredient_item.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodIngredientsSection extends StatelessWidget {
  const FoodIngredientsSection({super.key, this.mealData});
  final MealDetailsEntity? mealData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: RPadding(
        padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.ingredients.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const RSizedBox(height: 8),
            BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
              builder: (context, state) => BlurredContainer(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(20.r),
                halfTheBlurValue: 10,
                blurColor: theme.colorScheme.secondary.withValues(alpha: 0.8),
                child: ListView.separated(
                  padding: REdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => FoodIngredientItem(
                    mealIngredient: state.mealIngredients[index],
                    mealMeasure: state.mealMeasures[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const RSizedBox(height: 8),
                  itemCount: state.mealIngredients.length,
                ),
              ),
            ),
            const RSizedBox(height: 8),
            Text(
              AppText.recommendation.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const RSizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
