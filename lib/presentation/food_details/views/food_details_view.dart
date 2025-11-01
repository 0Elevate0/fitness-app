import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_details_view_body.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsView extends StatelessWidget {
  const FoodDetailsView({super.key, required this.foodDetailsArgument});
  final FoodDetailsArgument foodDetailsArgument;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodDetailsCubit>(
      create: (context) => getIt.get<FoodDetailsCubit>()
        ..doIntent(
          intent: FoodDetailsInitializationIntent(
            foodDetailsArgument: foodDetailsArgument,
          ),
        ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.foodDetailsBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: FoodDetailsViewBody(),
        ),
      ),
    );
  }
}
