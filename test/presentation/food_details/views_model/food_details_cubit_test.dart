import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/use_cases/meal_details/get_meal_details_use_case.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'food_details_cubit_test.mocks.dart';

@GenerateMocks([GetMealDetailsUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetMealDetailsUseCase mockGetMealDetailsUseCase;
  late FoodDetailsCubit cubit;
  late Result<MealDetailsEntity?> expectedSuccessResult;
  late Failure<MealDetailsEntity?> expectedFailureResult;
  late final MealDetailsEntity expectedMealEntity;
  late final FoodDetailsArgument expectedFoodDetailsArgument;
  late final String youtubeUrl;

  setUpAll(() {
    mockGetMealDetailsUseCase = MockGetMealDetailsUseCase();
    expectedMealEntity = const MealDetailsEntity(
      mealId: "52772",
      mealTitle: "Teriyaki Chicken Casserole",
      mealCategory: "Chicken",
      mealInstructions:
          "Preheat oven to 350°F. Cook chicken in a pan until browned. Combine with teriyaki sauce, vegetables, and rice, then bake for 30 minutes.",
      mealMealThumb: "chickenImage",
      mealYoutube: "youtube link",
      mealIngredient1: "soy sauce",
      mealIngredient2: "water",
      mealIngredient3: "brown sugar",
      mealIngredient4: "ground ginger",
      mealIngredient5: "minced garlic",
      mealIngredient6: "cornstarch",
      mealIngredient7: "chicken breasts",
      mealIngredient8: "stir-fry vegetables",
      mealIngredient9: "brown rice",
      mealMeasure1: "3/4 cup",
      mealMeasure2: "1/2 cup",
      mealMeasure3: "1/4 cup",
      mealMeasure4: "1/2 teaspoon",
      mealMeasure5: "1 teaspoon",
      mealMeasure6: "2 tablespoons",
      mealMeasure7: "2",
      mealMeasure8: "1 (12 oz.) bag",
      mealMeasure9: "3 cups",
    );
    expectedFoodDetailsArgument = const FoodDetailsArgument(
      mealsData: [
        MealEntity(id: "1234", name: "meat", thumbnail: "image"),
        MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
      ],
      mealId: "1234",
    );
    youtubeUrl = "https://www.youtube.com/watch?v=k9Ez0bUbXKc";
  });
  setUp(() {
    cubit = FoodDetailsCubit(mockGetMealDetailsUseCase);
    cubit.youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(youtubeUrl) ?? "",
    );
  });

  group("FoodDetailsCubit test", () {
    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [Loading, Success] when FoodDetailsInitializationIntent succeeds',
      build: () {
        expectedSuccessResult = Success<MealDetailsEntity?>(expectedMealEntity);
        provideDummy<Result<MealDetailsEntity?>>(expectedSuccessResult);
        when(
          mockGetMealDetailsUseCase.invoke(mealId: anyNamed("mealId")),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: FoodDetailsInitializationIntent(
          foodDetailsArgument: expectedFoodDetailsArgument,
        ),
      ),
      expect: () => [
        isA<FoodDetailsState>()
            .having(
              (state) => state.allCategoryMeals,
              "Is having the same data",
              equals(expectedFoodDetailsArgument.mealsData),
            )
            .having(
              (state) => state.mealsRecommendation,
              "Is having the expected data",
              equals(
                expectedFoodDetailsArgument.mealsData
                    .where(
                      (meal) => meal.id != expectedFoodDetailsArgument.mealId,
                    )
                    .toList(),
              ),
            ),
        isA<FoodDetailsState>().having(
          (state) => state.mealsDetailsStatus.isLoading,
          "Is in Loading state",
          equals(true),
        ),
        isA<FoodDetailsState>()
            .having(
              (state) => state.mealsDetailsStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.mealsDetailsStatus.data,
              "Is having the same data",
              equals(
                (expectedSuccessResult as Success<MealDetailsEntity?>).data,
              ),
            ),
      ],
      verify: (_) {
        verify(
          mockGetMealDetailsUseCase.invoke(mealId: anyNamed("mealId")),
        ).called(1);
      },
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [Loading, Failure] when FoodDetailsInitializationIntent fails',
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to login",
          ),
        );
        provideDummy<Result<MealDetailsEntity?>>(expectedFailureResult);
        when(
          mockGetMealDetailsUseCase.invoke(mealId: anyNamed("mealId")),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: FoodDetailsInitializationIntent(
          foodDetailsArgument: expectedFoodDetailsArgument,
        ),
      ),
      expect: () => [
        isA<FoodDetailsState>()
            .having(
              (state) => state.allCategoryMeals,
              "Is having the same data",
              equals(expectedFoodDetailsArgument.mealsData),
            )
            .having(
              (state) => state.mealsRecommendation,
              "Is having the expected data",
              equals(
                expectedFoodDetailsArgument.mealsData
                    .where(
                      (meal) => meal.id != expectedFoodDetailsArgument.mealId,
                    )
                    .toList(),
              ),
            ),
        isA<FoodDetailsState>().having(
          (state) => state.mealsDetailsStatus.isLoading,
          "Is in Loading state",
          equals(true),
        ),
        isA<FoodDetailsState>()
            .having(
              (state) => state.mealsDetailsStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.mealsDetailsStatus.error?.message,
              "Is having the same error message",
              equals(expectedFailureResult.responseException.message),
            ),
        isA<FoodDetailsState>().having(
          (state) => state.mealsDetailsStatus.isInitial,
          "Is back to Initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockGetMealDetailsUseCase.invoke(mealId: anyNamed("mealId")),
        ).called(1);
      },
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits isYoutubeVideoOpened with true value when OpenYoutubeVideoIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: OpenYoutubeVideoIntent(youtubeUrl: youtubeUrl),
      ),
      expect: () => [
        isA<FoodDetailsState>().having(
          (state) => state.isYoutubeVideoOpened,
          "Is having the expected data",
          equals(true),
        ),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits isYoutubeVideoOpened with false value when CloseYoutubeVideoIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: const CloseYoutubeVideoIntent()),
      expect: () => [
        isA<FoodDetailsState>().having(
          (state) => state.isYoutubeVideoOpened,
          "Is having the expected data",
          equals(false),
        ),
      ],
    );
  });
}
