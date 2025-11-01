import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';

sealed class FoodIntent {
  const FoodIntent();
}

final class InitCategoryGroup extends FoodIntent {
  final MealsArgument argument;

  const InitCategoryGroup({required this.argument});
}

final class GetMealsIntent extends FoodIntent {
  final String category;

  const GetMealsIntent({required this.category});
}

final class ChangeFoodCategoryIntent extends FoodIntent {
  final MealCategoryEntity category;
  final bool fromSwipe;

  const ChangeFoodCategoryIntent({
    required this.category,
    required this.fromSwipe,
  });
}
