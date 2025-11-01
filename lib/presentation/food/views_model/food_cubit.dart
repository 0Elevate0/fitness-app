import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/domain/use_cases/meals_list/get_meals_list_use_case.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart'; // Import for PageController
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState> {
  final GetMealsListUseCase _getMealsListUseCase;
  PageController? pageController;

  FoodCubit(this._getMealsListUseCase) : super(const FoodState());

  Future<void> doIntent({required FoodIntent intent}) async {
    switch (intent) {
      case GetMealsIntent():
        await _fetchMealsList(intent.category);
      case ChangeFoodCategoryIntent():
        await _selectCategory(
          category: intent.category,
          fromSwipe: intent.fromSwipe,
        );
      case InitCategoryGroup():
        await _onInit(intent.argument);
    }
  }

  Future<void> _onInit(MealsArgument? argument) async {
    if (argument == null) return;

    final initialIndex =
        argument.categories?.indexWhere(
          (c) => c.idCategory == argument.selectedCategory?.idCategory,
        ) ??
        0;

    pageController = PageController(
      initialPage: initialIndex.isNegative ? 0 : initialIndex,
    );

    emit(
      state.copyWith(
        mealsArgument: argument,
        selectedCategory: argument.selectedCategory,
        tabIndex: initialIndex.isNegative ? 0 : initialIndex,
      ),
    );
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

  Future<void> _selectCategory({
    MealCategoryEntity? category,
    bool fromSwipe = false,
  }) async {
    if (category?.idCategory == state.selectedCategory?.idCategory ||
        category == null) {
      return;
    }
    final newIndex =
        state.mealsArgument?.categories?.indexWhere(
          (c) => c.idCategory == category.idCategory,
        ) ??
        0;

    if (!fromSwipe) {
      pageController?.animateToPage(
        newIndex.isNegative ? 0 : newIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    emit(
      state.copyWith(
        selectedCategory: category,
        tabIndex: newIndex.isNegative ? 0 : newIndex,
      ),
    );
  }

  @override
  Future<void> close() {
    pageController?.dispose();
    return super.close();
  }
}
