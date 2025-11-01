import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_recommendation_item.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodRecommendationGridView extends StatelessWidget {
  const FoodRecommendationGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
      builder: (context, state) => SliverPadding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.r,
            mainAxisSpacing: 16.r,
          ),
          itemBuilder: (context, index) => FoodRecommendationItem(
            mealData: state.mealsRecommendation[index],
            onTap: () => Navigator.of(context).pushReplacementNamed(
              RouteNames.foodDetails,
              arguments: FoodDetailsArgument(
                mealsData: state.allCategoryMeals,
                mealId: state.mealsRecommendation[index].id ?? "",
              ),
            ),
          ),
          itemCount: state.mealsRecommendation.length,
        ),
      ),
    );
  }
}
