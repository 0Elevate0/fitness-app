import 'package:fitness_app/presentation/home/views/widgets/categories_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/home_app_bar.dart';
import 'package:fitness_app/presentation/home/views/widgets/meals_recommendation_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/popular_training_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/recommendation_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/workouts_section.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          current.mealsCategoriesStatus.isFailure ||
          current.musclesByGroupStatus.isFailure ||
          current.musclesGroupStatus.isFailure ||
          current.recommendationStatus.isFailure,
      listener: (context, state) {
        if (state.mealsCategoriesStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mealsCategoriesStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.musclesByGroupStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesByGroupStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.musclesGroupStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.musclesGroupStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.recommendationStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.recommendationStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: BlurredLayerView(
        child: SingleChildScrollView(
          padding: REdgeInsets.only(left: 16, right: 16, top: 20, bottom: 112),
          physics: const BouncingScrollPhysics(),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              RSizedBox(height: 24),
              CategoriesSection(),
              RSizedBox(height: 24),
              RecommendationSection(),
              RSizedBox(height: 16),
              WorkoutsSection(),
              RSizedBox(height: 16),
              MealsRecommendationSection(),
              RSizedBox(height: 24),
              PopularTrainingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
