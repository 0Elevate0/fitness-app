import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/use_cases/meals_list/get_meals_list_use_case.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_intent.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_cubit_test.mocks.dart';

@GenerateMocks([GetMealsListUseCase])
void main() {
  late MockGetMealsListUseCase mockGetMealsListUseCase;
  late FoodCubit cubit;

  provideDummy<Result<List<MealEntity>>>(Success(<MealEntity>[]));

  final mockMealCategory = const MealCategoryEntity(
    idCategory: '1',
    strCategory: 'Breakfast',
  );
  final mockMeals = [
    const MealEntity(id: 'm1', name: 'Omelette', thumbnail: ''),
    const MealEntity(id: 'm2', name: 'Pancakes', thumbnail: ''),
  ];

  setUp(() {
    mockGetMealsListUseCase = MockGetMealsListUseCase();
    cubit = FoodCubit(mockGetMealsListUseCase);

    when(
      mockGetMealsListUseCase.invoke(any),
    ).thenAnswer((_) async => Success(mockMeals));
  });


  group('FoodCubit Tests', () {
    blocTest<FoodCubit, FoodState>(
      'emits success when fetching meals succeeds',
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: GetMealsIntent(category: mockMealCategory.strCategory??''),
      ),
      expect: () => containsAllInOrder([
        isA<FoodState>().having(
          (s) => s.mealsListStatus.isLoading,
          'loading',
          true,
        ),
        isA<FoodState>().having(
          (s) => s.mealsListStatus.isSuccess,
          'success',
          true,
        ),
      ]),
    );

    blocTest<FoodCubit, FoodState>(
      'emits failure when fetching meals fails',
      build: () {
        when(mockGetMealsListUseCase.invoke(any)).thenAnswer(
          (_) async => Failure(
            responseException: const ResponseException(
              message: 'Error fetching meals',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: GetMealsIntent(category: mockMealCategory.strCategory??''),
      ),
      expect: () => containsAllInOrder([
        isA<FoodState>().having(
          (s) => s.mealsListStatus.isLoading,
          'loading',
          true,
        ),
        isA<FoodState>().having(
          (s) => s.mealsListStatus.isFailure,
          'failure',
          true,
        ),
      ]),
    );

    blocTest<FoodCubit, FoodState>(
      'emits updated state when selecting a category',
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: ChangeFoodCategoryIntent(category: mockMealCategory),
      ),
      expect: () => [
        isA<FoodState>().having(
          (s) => s.selectedCategory?.idCategory,
          'selected category',
          mockMealCategory.idCategory,
        ),
      ],
    );
  });
}
