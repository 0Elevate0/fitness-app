import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/use_cases/meals_categories/get_all_meals_categories_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_by_muscle_group/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_group/get_all_muscles_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/recommendation_random_muscles/get_recommendation_random_muscles_use_case.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetRecommendationRandomMusclesUseCase
  _getRecommendationRandomMusclesUseCase;
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetAllMusclesByMuscleGroupUseCase _getAllMusclesByMuscleGroupUseCase;
  final GetAllMealsCategoriesUseCase _getAllMealsCategoriesUseCase;
  HomeCubit(
    this._getRecommendationRandomMusclesUseCase,
    this._getAllMusclesGroupUseCase,
    this._getAllMusclesByMuscleGroupUseCase,
    this._getAllMealsCategoriesUseCase,
  ) : super(const HomeState());

  Future<void> doIntent({required HomeIntent intent}) async {
    switch (intent) {
      case HomeInitializationIntent():
        await _onInit();
        break;
      case ChangeMusclesGroupIntent():
        await _fetchAllMusclesByGroup(muscleGroupId: intent.muscleGroupId);
        break;
    }
  }

  Future<void> _onInit() async {
    await _fetchAllRecommendation();
    await _fetchAllMusclesGroup();
    await _fetchAllMusclesByGroup();
    await _fetchAllMealsCategories();
  }

  Future<void> _fetchAllRecommendation() async {
    emit(state.copyWith(recommendationStatus: const StateStatus.loading()));
    final result = await _getRecommendationRandomMusclesUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<MuscleEntity>>():
        emit(
          state.copyWith(
            recommendationStatus: StateStatus.success(result.data),
          ),
        );
        break;
      case Failure<List<MuscleEntity>>():
        emit(
          state.copyWith(
            recommendationStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(recommendationStatus: const StateStatus.initial()));
    }
  }

  Future<void> _fetchAllMusclesGroup() async {
    emit(state.copyWith(musclesGroupStatus: const StateStatus.loading()));
    final result = await _getAllMusclesGroupUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupStatus: StateStatus.success(result.data),
            selectedMuscleGroup: result.data.first,
          ),
        );
        break;
      case Failure<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(musclesGroupStatus: const StateStatus.initial()));
    }
  }

  Future<void> _fetchAllMusclesByGroup({String? muscleGroupId}) async {
    if (muscleGroupId != state.selectedMuscleGroup?.id) {
      emit(
        state.copyWith(
          musclesByGroupStatus: const StateStatus.loading(),
          selectedMuscleGroup: muscleGroupId != null
              ? state.musclesGroupStatus.data?.firstWhere(
                  (muscleGroup) => muscleGroup.id == muscleGroupId,
                )
              : state.selectedMuscleGroup,
        ),
      );
      final result = await _getAllMusclesByMuscleGroupUseCase.invoke(
        muscleGroupId:
            muscleGroupId ??
            (state.musclesGroupStatus.data?[0].id ??
                "67c79f3526895f87ce0aa96e"),
      );
      if (isClosed) return;
      switch (result) {
        case Success<List<MuscleEntity>>():
          emit(
            state.copyWith(
              musclesByGroupStatus: StateStatus.success(result.data),
            ),
          );
          break;
        case Failure<List<MuscleEntity>>():
          emit(
            state.copyWith(
              musclesByGroupStatus: StateStatus.failure(
                result.responseException,
              ),
            ),
          );
          emit(
            state.copyWith(musclesByGroupStatus: const StateStatus.initial()),
          );
      }
    }
  }

  Future<void> _fetchAllMealsCategories() async {
    emit(state.copyWith(mealsCategoriesStatus: const StateStatus.loading()));
    final result = await _getAllMealsCategoriesUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<MealCategoryEntity>>():
        emit(
          state.copyWith(
            mealsCategoriesStatus: StateStatus.success(result.data),
          ),
        );
        break;
      case Failure<List<MealCategoryEntity>>():
        emit(
          state.copyWith(
            mealsCategoriesStatus: StateStatus.failure(
              result.responseException,
            ),
          ),
        );
        emit(
          state.copyWith(mealsCategoriesStatus: const StateStatus.initial()),
        );
    }
  }
}
