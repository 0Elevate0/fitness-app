import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/use_cases/get_meal_details/get_meal_details_use_case.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_intent.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  FoodDetailsCubit(this._getMealDetailsUseCase) : super(const FoodDetailsState());

  Future<void> doIntent({required FoodDetailsIntent intent}) async {
    switch (intent) {
      case GetFoodDetailsIntent():
        await _fetchMealDetails(mealId: intent.mealId);
        break;
    }
  }

  Future<void> _fetchMealDetails({required String mealId}) async {
    emit(state.copyWith(mealDetailsStatus: const StateStatus.loading()));

    final result = await _getMealDetailsUseCase.invoke(mealId: mealId);

    if (isClosed) return;

    switch (result) {
      case Success<MealDetailsEntity>():
        emit(
          state.copyWith(
            mealDetailsStatus: StateStatus.success(result.data),
          ),
        );
        break;
      case Failure<MealDetailsEntity>():
        emit(
          state.copyWith(
            mealDetailsStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(mealDetailsStatus: const StateStatus.initial()));
    }
  }
}