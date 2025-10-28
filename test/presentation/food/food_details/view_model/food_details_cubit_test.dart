import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/use_cases/get_meal_details/get_meal_details_use_case.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_cubit.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_intent.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_cubit_test.mocks.dart';

@GenerateMocks([GetMealDetailsUseCaseInterface])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetMealDetailsUseCaseInterface mockGetMealDetailsUseCase;
  late FoodDetailsCubit cubit;
  late Result<MealDetailsEntity> expectedSuccessResult;
  late Failure<MealDetailsEntity> expectedFailureResult;

  const mockMealEntity = MealDetailsEntity(
    idMeal: '52959',
    strMeal: 'Baked salmon',
    strInstructions: 'Mock instructions',
    ingredients: [],
  );

  setUpAll(() {
    mockGetMealDetailsUseCase = MockGetMealDetailsUseCaseInterface();
  });

  setUp(() {
    cubit = FoodDetailsCubit(mockGetMealDetailsUseCase as GetMealDetailsUseCase);
  });

  group("FoodDetails Cubit Test", () {
    const testMealId = '52959';
    final testIntent = const GetFoodDetailsIntent(mealId: testMealId);

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [Loading, Success] when GetFoodDetailsIntent succeeds',
      build: () {
        expectedSuccessResult =  Success<MealDetailsEntity>(mockMealEntity);
        provideDummy<Result<MealDetailsEntity>>(expectedSuccessResult);
        when(
          mockGetMealDetailsUseCase.invoke(
            mealId: anyNamed("mealId"),
          ),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: testIntent),
      expect: () => [
        isA<FoodDetailsState>().having(
              (state) => state.mealDetailsStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<FoodDetailsState>()
            .having(
              (state) => state.mealDetailsStatus.isSuccess,
          "Is Success State",
          equals(true),
        )
            .having(
              (state) => state.mealDetailsStatus.data,
          'Success Data',
          equals(mockMealEntity),
        ),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      "emits [Loading, Failure, Initial] when GetFoodDetailsIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "Failed to load meal details",
          ),
        );
        provideDummy<Result<MealDetailsEntity>>(expectedFailureResult);
        when(
          mockGetMealDetailsUseCase.invoke(
            mealId: anyNamed("mealId"),
          ),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: testIntent),
      expect: () => [
        isA<FoodDetailsState>().having(
              (state) => state.mealDetailsStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<FoodDetailsState>()
            .having(
              (state) => state.mealDetailsStatus.isFailure,
          "Is Failure State",
          equals(true),
        )
            .having(
              (state) => state.mealDetailsStatus.error?.message,
          'responseException.message',
          expectedFailureResult.responseException.message,
        ),
        isA<FoodDetailsState>().having(
              (state) => state.mealDetailsStatus.isInitial,
          "Is Initial State",
          equals(true),
        ),
      ],
    );
  });
}