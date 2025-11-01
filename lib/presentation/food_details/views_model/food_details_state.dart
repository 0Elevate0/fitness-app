import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';

final class FoodDetailsState extends Equatable {
  final StateStatus<MealDetailsEntity?> mealsDetailsStatus;
  final List<MealEntity> mealsRecommendation;
  final List<MealEntity> allCategoryMeals;
  final List<String> mealIngredients;
  final List<String> mealMeasures;
  final bool isYoutubeVideoOpened;
  const FoodDetailsState({
    this.mealsDetailsStatus = const StateStatus.initial(),
    this.mealsRecommendation = const [],
    this.allCategoryMeals = const [],
    this.mealIngredients = const [],
    this.mealMeasures = const [],
    this.isYoutubeVideoOpened = false,
  });

  FoodDetailsState copyWith({
    StateStatus<MealDetailsEntity?>? mealsDetailsStatus,
    List<MealEntity>? mealsRecommendation,
    List<MealEntity>? allCategoryMeals,
    List<String>? mealIngredients,
    List<String>? mealMeasures,
    bool? isYoutubeVideoOpened,
  }) {
    return FoodDetailsState(
      mealsDetailsStatus: mealsDetailsStatus ?? this.mealsDetailsStatus,
      mealsRecommendation: mealsRecommendation ?? this.mealsRecommendation,
      allCategoryMeals: allCategoryMeals ?? this.allCategoryMeals,
      mealIngredients: mealIngredients ?? this.mealIngredients,
      mealMeasures: mealMeasures ?? this.mealMeasures,
      isYoutubeVideoOpened: isYoutubeVideoOpened ?? this.isYoutubeVideoOpened,
    );
  }

  @override
  List<Object?> get props => [
    mealsDetailsStatus,
    mealsRecommendation,
    allCategoryMeals,
    mealIngredients,
    mealMeasures,
    isYoutubeVideoOpened,
  ];
}
