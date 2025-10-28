import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/use_cases/meals_categories/get_all_meals_categories_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_by_muscle_group/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_group/get_all_muscles_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/recommendation_random_muscles/get_recommendation_random_muscles_use_case.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetRecommendationRandomMusclesUseCase,
  GetAllMusclesGroupUseCase,
  GetAllMusclesByMuscleGroupUseCase,
  GetAllMealsCategoriesUseCase,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetRecommendationRandomMusclesUseCase
  mockGetRecommendationRandomMusclesUseCase;
  late MockGetAllMusclesGroupUseCase mockGetAllMusclesGroupUseCase;
  late MockGetAllMusclesByMuscleGroupUseCase
  mockGetAllMusclesByMuscleGroupUseCase;
  late MockGetAllMealsCategoriesUseCase mockGetAllMealsCategoriesUseCase;
  late HomeCubit homeCubit;
  late Result<List<MuscleEntity>> expectedRecommendationSuccessResult;
  late Failure<List<MuscleEntity>> expectedRecommendationFailureResult;
  late Result<List<MuscleGroupEntity>> expectedMusclesGroupSuccessResult;
  late Failure<List<MuscleGroupEntity>> expectedMusclesGroupFailureResult;
  late Result<List<MuscleEntity>> expectedMusclesByGroupSuccessResult;
  late Failure<List<MuscleEntity>> expectedMusclesByGroupFailureResult;
  late Result<List<MealCategoryEntity>> expectedMealsCategoriesSuccessResult;
  late Failure<List<MealCategoryEntity>> expectedMealsCategoriesFailureResult;

  setUpAll(() {
    mockGetRecommendationRandomMusclesUseCase =
        MockGetRecommendationRandomMusclesUseCase();
    mockGetAllMusclesGroupUseCase = MockGetAllMusclesGroupUseCase();
    mockGetAllMusclesByMuscleGroupUseCase =
        MockGetAllMusclesByMuscleGroupUseCase();
    mockGetAllMealsCategoriesUseCase = MockGetAllMealsCategoriesUseCase();
    expectedRecommendationSuccessResult = expectedMusclesByGroupSuccessResult =
        Success(const [
          MuscleEntity(image: "shoulder image", name: "shoulder", id: "1"),
          MuscleEntity(image: "triceps image", name: "triceps", id: "2"),
        ]);
    expectedMusclesGroupSuccessResult = Success(const [
      MuscleGroupEntity(name: "shoulder", id: "1"),
      MuscleGroupEntity(name: "triceps", id: "2"),
    ]);
    expectedMealsCategoriesSuccessResult = Success(const [
      MealCategoryEntity(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
        strCategoryDescription:
            "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
      ),
      MealCategoryEntity(
        idCategory: "2",
        strCategory: "Chicken",
        strCategoryThumb:
            "https://www.themealdb.com/images/category/chicken.png",
        strCategoryDescription:
            "Chicken is one of the most common types of poultry in the world, known for its versatility in cooking.",
      ),
    ]);
    expectedRecommendationFailureResult = Failure(
      responseException: const ResponseException(
        message: "failed to load recommendation muscles data",
      ),
    );
    expectedMusclesGroupFailureResult = Failure(
      responseException: const ResponseException(
        message: "failed to load muscles group data",
      ),
    );
    expectedMusclesByGroupFailureResult = Failure(
      responseException: const ResponseException(
        message: "failed to load muscles by group data",
      ),
    );
    expectedMealsCategoriesFailureResult = Failure(
      responseException: const ResponseException(
        message: "failed to load meals categories data",
      ),
    );
  });
  setUp(() {
    homeCubit = HomeCubit(
      mockGetRecommendationRandomMusclesUseCase,
      mockGetAllMusclesGroupUseCase,
      mockGetAllMusclesByMuscleGroupUseCase,
      mockGetAllMealsCategoriesUseCase,
    );
  });

  group("HomeCubit test", () {
    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Success] when HomeInitializationIntent succeeds',
      build: () {
        provideDummy<Result<List<MuscleEntity>>>(
          expectedRecommendationSuccessResult,
        );
        provideDummy<Result<List<MuscleGroupEntity>>>(
          expectedMusclesGroupSuccessResult,
        );
        provideDummy<Result<List<MuscleEntity>>>(
          expectedMusclesByGroupSuccessResult,
        );
        provideDummy<Result<List<MealCategoryEntity>>>(
          expectedMealsCategoriesSuccessResult,
        );
        when(
          mockGetRecommendationRandomMusclesUseCase.invoke(),
        ).thenAnswer((_) async => expectedRecommendationSuccessResult);
        when(
          mockGetAllMusclesGroupUseCase.invoke(),
        ).thenAnswer((_) async => expectedMusclesGroupSuccessResult);
        when(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).thenAnswer((_) async => expectedMusclesByGroupSuccessResult);
        when(
          mockGetAllMealsCategoriesUseCase.invoke(),
        ).thenAnswer((_) async => expectedMealsCategoriesSuccessResult);
        return homeCubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const HomeInitializationIntent()),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.recommendationStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.recommendationStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.recommendationStatus.data,
              "Is having the expected data",
              equals(
                (expectedRecommendationSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data,
              ),
            )
            .having(
              (state) => state.recommendationStatus.data?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedRecommendationSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.recommendationStatus.data?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedRecommendationSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(1),
              ),
            ),

        isA<HomeState>().having(
          (state) => state.musclesGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesGroupStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.musclesGroupStatus.data,
              "Is having the expected data",
              equals(
                (expectedMusclesGroupSuccessResult
                        as Success<List<MuscleGroupEntity>>)
                    .data,
              ),
            )
            .having(
              (state) => state.musclesGroupStatus.data?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedMusclesGroupSuccessResult
                        as Success<List<MuscleGroupEntity>>)
                    .data
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.musclesGroupStatus.data?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedMusclesGroupSuccessResult
                        as Success<List<MuscleGroupEntity>>)
                    .data
                    .elementAt(1),
              ),
            ),

        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesByGroupStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.musclesByGroupStatus.data,
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data,
              ),
            )
            .having(
              (state) => state.musclesByGroupStatus.data?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.musclesByGroupStatus.data?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(1),
              ),
            )
            .having(
              (state) => state.selectedMuscleGroup,
              "Is having selectedMuscleGroup not equal to null",
              equals(isNotNull),
            ),

        isA<HomeState>().having(
          (state) => state.mealsCategoriesStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.mealsCategoriesStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.mealsCategoriesStatus.data,
              "Is having the expected data",
              equals(
                (expectedMealsCategoriesSuccessResult
                        as Success<List<MealCategoryEntity>>)
                    .data,
              ),
            )
            .having(
              (state) => state.mealsCategoriesStatus.data?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedMealsCategoriesSuccessResult
                        as Success<List<MealCategoryEntity>>)
                    .data
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.mealsCategoriesStatus.data?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedMealsCategoriesSuccessResult
                        as Success<List<MealCategoryEntity>>)
                    .data
                    .elementAt(1),
              ),
            ),
      ],
      verify: (_) {
        verify(mockGetRecommendationRandomMusclesUseCase.invoke()).called(1);
        verify(mockGetAllMusclesGroupUseCase.invoke()).called(1);
        verify(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).called(1);
        verify(mockGetAllMealsCategoriesUseCase.invoke()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      "emits [Loading, Failure] when HomeInitializationIntent is Called",
      build: () {
        provideDummy<Result<List<MuscleEntity>>>(
          expectedRecommendationFailureResult,
        );
        provideDummy<Result<List<MuscleGroupEntity>>>(
          expectedMusclesGroupFailureResult,
        );
        provideDummy<Result<List<MuscleEntity>>>(
          expectedMusclesByGroupFailureResult,
        );
        provideDummy<Result<List<MealCategoryEntity>>>(
          expectedMealsCategoriesFailureResult,
        );
        when(
          mockGetRecommendationRandomMusclesUseCase.invoke(),
        ).thenAnswer((_) async => expectedRecommendationFailureResult);
        when(
          mockGetAllMusclesGroupUseCase.invoke(),
        ).thenAnswer((_) async => expectedMusclesGroupFailureResult);
        when(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).thenAnswer((_) async => expectedMusclesByGroupFailureResult);
        when(
          mockGetAllMealsCategoriesUseCase.invoke(),
        ).thenAnswer((_) async => expectedMealsCategoriesFailureResult);
        homeCubit.emit(
          homeCubit.state.copyWith(
            selectedMuscleGroup: const MuscleGroupEntity(
              id: "test-id",
              name: "Chest",
            ),
          ),
        );
        return homeCubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const HomeInitializationIntent()),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.recommendationStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.recommendationStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.recommendationStatus.error?.message,
              "Is having the expected failure message",
              equals(
                expectedRecommendationFailureResult.responseException.message,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.recommendationStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),

        isA<HomeState>().having(
          (state) => state.musclesGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesGroupStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.musclesGroupStatus.error?.message,
              "Is having the expected failure message",
              equals(
                expectedMusclesGroupFailureResult.responseException.message,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.musclesGroupStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),

        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesByGroupStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.musclesByGroupStatus.error?.message,
              "Is having the expected failure message",
              equals(
                expectedMusclesByGroupFailureResult.responseException.message,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),

        isA<HomeState>().having(
          (state) => state.mealsCategoriesStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.mealsCategoriesStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.mealsCategoriesStatus.error?.message,
              "Is having the expected failure message",
              equals(
                expectedMealsCategoriesFailureResult.responseException.message,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.mealsCategoriesStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(mockGetRecommendationRandomMusclesUseCase.invoke()).called(1);
        verify(mockGetAllMusclesGroupUseCase.invoke()).called(1);
        verify(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).called(1);
        verify(mockGetAllMealsCategoriesUseCase.invoke()).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [Loading, Success] when ChangeMusclesGroupIntent succeeds',
      build: () {
        provideDummy<Result<List<MuscleEntity>>>(
          expectedMusclesByGroupSuccessResult,
        );
        when(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).thenAnswer((_) async => expectedMusclesByGroupSuccessResult);
        return homeCubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeMusclesGroupIntent(muscleGroupId: "1234"),
      ),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesByGroupStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.musclesByGroupStatus.data,
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data,
              ),
            )
            .having(
              (state) => state.musclesByGroupStatus.data?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.musclesByGroupStatus.data?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedMusclesByGroupSuccessResult
                        as Success<List<MuscleEntity>>)
                    .data
                    .elementAt(1),
              ),
            )
            .having(
              (state) => state.selectedMuscleGroup,
              "Should remain null because it is not assigned yet",
              isNull,
            ),
      ],
      verify: (_) {
        verify(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).called(1);
      },
    );

    blocTest<HomeCubit, HomeState>(
      "emits [Loading, Failure] when ChangeMusclesGroupIntent is Called",
      build: () {
        provideDummy<Result<List<MuscleEntity>>>(
          expectedMusclesByGroupFailureResult,
        );
        when(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).thenAnswer((_) async => expectedMusclesByGroupFailureResult);
        homeCubit.emit(
          homeCubit.state.copyWith(
            selectedMuscleGroup: const MuscleGroupEntity(
              id: "test-id",
              name: "Chest",
            ),
          ),
        );
        return homeCubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeMusclesGroupIntent(muscleGroupId: "1234"),
      ),
      expect: () => [
        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HomeState>()
            .having(
              (state) => state.musclesByGroupStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.musclesByGroupStatus.error?.message,
              "Is having the expected failure message",
              equals(
                expectedMusclesByGroupFailureResult.responseException.message,
              ),
            ),
        isA<HomeState>().having(
          (state) => state.musclesByGroupStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed("muscleGroupId"),
          ),
        ).called(1);
      },
    );
  });
}
