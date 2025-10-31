import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';

final class FoodState extends Equatable{
  final StateStatus<List<MealEntity>>mealsByCategoryStatus;
  const FoodState({
    this.mealsByCategoryStatus=const StateStatus.initial(),
  });

  FoodState copyWith({
    StateStatus<List<MealEntity>>?mealsByCategoryStatus,
  }){
    return FoodState(
      mealsByCategoryStatus:mealsByCategoryStatus??this.mealsByCategoryStatus,
    );
  }

  @override
  List<Object?> get props => [
    mealsByCategoryStatus,
  ];
}