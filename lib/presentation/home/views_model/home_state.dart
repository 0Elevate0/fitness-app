import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';

final class HomeState extends Equatable {
  final StateStatus<List<MuscleEntity>> recommendationStatus;
  final StateStatus<List<MuscleGroupEntity>> musclesGroupStatus;
  final StateStatus<List<MuscleEntity>> musclesByGroupStatus;
  final StateStatus<List<MealCategoryEntity>> mealsCategoriesStatus;
  final MuscleGroupEntity? selectedMuscleGroup;

  const HomeState({
    this.recommendationStatus = const StateStatus.initial(),
    this.musclesGroupStatus = const StateStatus.initial(),
    this.musclesByGroupStatus = const StateStatus.initial(),
    this.mealsCategoriesStatus = const StateStatus.initial(),
    this.selectedMuscleGroup,
  });

  HomeState copyWith({
    StateStatus<List<MuscleEntity>>? recommendationStatus,
    StateStatus<List<MuscleGroupEntity>>? musclesGroupStatus,
    StateStatus<List<MuscleEntity>>? musclesByGroupStatus,
    StateStatus<List<MealCategoryEntity>>? mealsCategoriesStatus,
    MuscleGroupEntity? selectedMuscleGroup,
  }) {
    return HomeState(
      recommendationStatus: recommendationStatus ?? this.recommendationStatus,
      musclesGroupStatus: musclesGroupStatus ?? this.musclesGroupStatus,
      musclesByGroupStatus: musclesByGroupStatus ?? this.musclesByGroupStatus,
      mealsCategoriesStatus:
          mealsCategoriesStatus ?? this.mealsCategoriesStatus,
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
    );
  }

  @override
  List<Object?> get props => [
    recommendationStatus,
    musclesGroupStatus,
    musclesByGroupStatus,
    mealsCategoriesStatus,
    selectedMuscleGroup,
  ];
}
