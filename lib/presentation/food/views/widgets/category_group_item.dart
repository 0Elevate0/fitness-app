import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart'; // Import state
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryGroupItem extends StatelessWidget {
  const CategoryGroupItem({
    super.key,
    required this.mealCategoryData,
    required this.isSelected,
  });

  final MealCategoryEntity mealCategoryData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foodCubit = BlocProvider.of<FoodCubit>(context);

    return BlocListener<FoodCubit, FoodState>(
      listenWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      listener: (context, state) {
        if (isSelected) {
          Scrollable.ensureVisible(
            context,
            alignment: 0.5,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: GestureDetector(
        onTap: () async {
          await foodCubit.doIntent(
            intent: ChangeFoodCategoryIntent(
              category: mealCategoryData,
              fromSwipe: false,
            ),
          );
          await foodCubit.doIntent(
            intent: GetMealsIntent(
              category: mealCategoryData.strCategory ?? "",
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          padding: REdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            border: isSelected
                ? Border.all(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                  )
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                      blurRadius: 8.r,
                      blurStyle: BlurStyle.outer,
                    ),
                  ]
                : null,
          ),
          child: Text(
            mealCategoryData.strCategory ?? AppText.notProvided.tr(),
            style: isSelected
                ? theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSecondary,
                  )
                : theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
