import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/domain/use_cases/meals_list/get_meals_list_use_case.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState> {
  final GetMealsListUseCase _getMealsListUseCase;

  FoodCubit(this._getMealsListUseCase) : super(const FoodState());

  Future<void> doIntent({required FoodIntent intent}) async {
    switch (intent) {
      case GetMealsIntent():
        await _fetchMealsList(intent.category);
      case ChangeFoodCategoryIntent():
        await _selectCategory(category: intent.category);
      case InitCategoryGroup():
        await _onInit(intent.argument);
    }
  }

  Future<void> _onInit(MealsArgument? group) async {
    emit(state.copyWith(mealsArgument: group));
  }

  Future<void> _fetchMealsList(category) async {
    emit(state.copyWith(mealsListStatus: const StateStatus.loading()));
    final result = await _getMealsListUseCase.invoke(category);
    if (isClosed) return;
    switch (result) {
      case Success<List<MealEntity>>():
        emit(state.copyWith(mealsListStatus: StateStatus.success(result.data)));
        break;
      case Failure<List<MealEntity>>():
        emit(
          state.copyWith(
            mealsListStatus: StateStatus.failure(
              ResponseException(message: result.responseException.message),
            ),
          ),
        );
    }
  }

  Future<void> _selectCategory({MealCategoryEntity? category}) async {
    if (category?.idCategory != state.selectedCategory?.idCategory) {
      emit(
        state.copyWith(selectedCategory: category ?? state.selectedCategory),
      );
    }
  }
}
