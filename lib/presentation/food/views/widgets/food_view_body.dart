import 'package:fitness_app/presentation/food/views/widgets/category_list.dart';
import 'package:fitness_app/presentation/food/views/widgets/meals_list.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodViewBody extends StatelessWidget {
  const FoodViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryList(),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<FoodCubit, FoodState>(
            buildWhen: (p, c) =>
                p.mealsArgument != c.mealsArgument || p.tabIndex != c.tabIndex,
            builder: (context, state) {
              final categories = state.mealsArgument?.categories ?? [];
              final pageController = context.read<FoodCubit>().pageController;

              return PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) => const MealsList(),
                onPageChanged: (index) {
                  final category = categories[index];
                  context.read<FoodCubit>().doIntent(
                    intent: ChangeFoodCategoryIntent(
                      category: category,
                      fromSwipe: true,
                    ),
                  );
                  context.read<FoodCubit>().doIntent(
                    intent: GetMealsIntent(
                      category: category.strCategory ?? "",
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
