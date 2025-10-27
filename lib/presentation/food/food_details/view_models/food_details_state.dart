import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';

final class FoodDetailsState extends Equatable {
  final StateStatus<MealDetailsEntity> mealDetailsStatus;

  const FoodDetailsState({
    this.mealDetailsStatus = const StateStatus.initial(),
  });

  FoodDetailsState copyWith({
    StateStatus<MealDetailsEntity>? mealDetailsStatus,
  }) {
    return FoodDetailsState(
      mealDetailsStatus: mealDetailsStatus ?? this.mealDetailsStatus,
    );
  }

  @override
  List<Object?> get props => [mealDetailsStatus];
}