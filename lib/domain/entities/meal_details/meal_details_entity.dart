import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/meal_details/ingredient_measure_entity.dart';

final class MealDetailsEntity extends Equatable {
  final String? idMeal;
  final String? strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final String? strSource;
  final List<IngredientMeasureEntity> ingredients;

  const MealDetailsEntity({
    this.idMeal,
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strSource,
    this.ingredients = const [],
  });

  @override
  List<Object?> get props => [
    idMeal,
    strMeal,
    strCategory,
    strArea,
    strInstructions,
    strMealThumb,
    strTags,
    strYoutube,
    strSource,
    ingredients,
  ];
}
