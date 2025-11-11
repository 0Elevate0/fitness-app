import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/meal_recommendation_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/recommendation_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealsRecommendationList extends StatelessWidget {
  const MealsRecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current.mealsCategoriesStatus.isLoading ||
          current.mealsCategoriesStatus.isSuccess,
      builder: (context, state) {
        if (state.mealsCategoriesStatus.isSuccess) {
          return RSizedBox(
            height: 104,
            child: (state.mealsCategoriesStatus.data?.isNotEmpty ?? false)
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => MealRecommendationItem(
                      mealCategoryData:
                          state.mealsCategoriesStatus.data![index],
                      categories: state.mealsCategoriesStatus.data ?? [],
                    ),
                    separatorBuilder: (_, _) => const RSizedBox(width: 16),
                    itemCount: state.mealsCategoriesStatus.data!.length,
                  )
                : Center(
                    child: Text(
                      AppText.emptyMealRecommendationMessage.tr(),
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
          );
        } else {
          return const RecommendationListShimmer();
        }
      },
    );
  }
}
