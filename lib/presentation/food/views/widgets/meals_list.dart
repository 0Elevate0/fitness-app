import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/food/views/widgets/meal_item.dart';
import 'package:fitness_app/presentation/food/views/widgets/shimmer/meals_grid_shimmer.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealsList extends StatelessWidget {
  const MealsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        if (state.mealsListStatus.isSuccess) {
          final meals = state.mealsListStatus.data ?? [];
          return meals.isNotEmpty
              ? GridView.builder(
                  padding: REdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18.h,
                    crossAxisSpacing: 18.w,
                    childAspectRatio: 1,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (_, index) => MealItem(mealData: meals[index]),
                )
              : Center(
                  child: Text(
                    AppText.emptyFoodGroupMessage.tr(),
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                );
        } else if (state.mealsListStatus.isFailure) {
          return Center(
            child: Text(
              state.mealsListStatus.error?.message ?? AppText.error,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }
        return const MealsGridShimmer();
      },
    );
  }
}
