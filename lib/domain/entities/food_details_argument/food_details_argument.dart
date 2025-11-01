import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';

final class FoodDetailsArgument extends Equatable {
  final List<MealEntity> mealsData;
  final String mealId;

  const FoodDetailsArgument({required this.mealsData, required this.mealId});

  @override
  List<Object?> get props => [mealsData, mealId];
}
