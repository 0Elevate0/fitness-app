import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_app_bar.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_view_body.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key, required this.argument});

  final MealsArgument argument;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<FoodCubit>(
      create: (context) => getIt.get<FoodCubit>()
        ..doIntent(
          intent: GetMealsIntent(
            category: argument.selectedCategory!.strCategory!,
          ),
        )
        ..doIntent(intent: InitCategoryGroup(argument: argument)),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.5),
          image: const DecorationImage(
            image: AssetImage(AppImages.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const SafeArea(
          child: Scaffold(
            appBar: FoodAppBar(),
            body: FoodViewBody(),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
