import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/food/food_details/view/widgets/food_details_view_body.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_cubit.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsView extends StatelessWidget {
  final String mealId;

  const FoodDetailsView({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodDetailsCubit>(
      create: (context) => getIt.get<FoodDetailsCubit>()
        ..doIntent(intent: GetFoodDetailsIntent(mealId: mealId)),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const FoodDetailsViewBody(),
      ),
    );
  }
}
