import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_app_bar.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_view_body.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key, required this.argument});

  final MealsArgument argument;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodCubit>(
      create: (context) => getIt.get<FoodCubit>()
        ..doIntent(intent: InitCategoryGroup(argument: argument))
        ..doIntent(
          intent: GetMealsIntent(
            category: argument.selectedCategory!.strCategory!,
          ),
        ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const SafeArea(
          child: Scaffold(
            appBar: FoodAppBar(),
            body: BlurredLayerView(child: FoodViewBody()),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
