import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';

final class FoodState extends Equatable {
  final StateStatus<List<MealEntity>> mealsListStatus;
  final MealsArgument? mealsArgument;
  final MealCategoryEntity? selectedCategory;

  const FoodState({
    this.mealsListStatus = const StateStatus.initial(),
    this.selectedCategory,
    this.mealsArgument,
  });

  FoodState copyWith({
    StateStatus<List<MealEntity>>? mealsListStatus,
    MealsArgument? mealsArgument,
    MealCategoryEntity? selectedCategory,
  }) {
    return FoodState(
      mealsListStatus: mealsListStatus ?? this.mealsListStatus,
      mealsArgument: mealsArgument ?? this.mealsArgument,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [mealsListStatus, selectedCategory, mealsArgument];
}
