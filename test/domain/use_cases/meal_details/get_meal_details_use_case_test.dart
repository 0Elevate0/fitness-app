import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/repositories/meal_details/meal_details_repository.dart';
import 'package:fitness_app/domain/use_cases/meal_details/get_meal_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_meal_details_use_case_test.mocks.dart';

@GenerateMocks([MealDetailsRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMealsCategories it should be called successfully from MealDetailsRepository and returns a List of MealCategoryEntity',
    () async {
      // Arrange
      final MockMealDetailsRepository mockedMealDetailsRepository =
          MockMealDetailsRepository();
      final getMealDetailsUseCase = GetMealDetailsUseCase(
        mockedMealDetailsRepository,
      );
      final expectedMealEntity = const MealDetailsEntity(
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
      final expectedResult = Success<MealDetailsEntity?>(expectedMealEntity);
      provideDummy<Result<MealDetailsEntity?>>(expectedResult);
      when(
        mockedMealDetailsRepository.getMealDetails(mealId: anyNamed("mealId")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getMealDetailsUseCase.invoke(mealId: "1234");

      // Assert
      expect(result, isA<Success<MealDetailsEntity?>>());
      final successResult = result as Success<MealDetailsEntity?>;
      expect(successResult.data, equals(expectedResult.data));
      expect(successResult.data?.mealId, equals(expectedResult.data?.mealId));
      expect(
        successResult.data?.mealTitle,
        equals(expectedResult.data?.mealTitle),
      );
      expect(
        successResult.data?.mealIngredient1,
        equals(expectedResult.data?.mealIngredient1),
      );
      expect(
        successResult.data?.mealIngredient2,
        equals(expectedResult.data?.mealIngredient2),
      );
      expect(
        successResult.data?.mealIngredient3,
        equals(expectedResult.data?.mealIngredient3),
      );
      expect(
        successResult.data?.mealIngredient4,
        equals(expectedResult.data?.mealIngredient4),
      );
      expect(
        successResult.data?.mealIngredient5,
        equals(expectedResult.data?.mealIngredient5),
      );
      expect(
        successResult.data?.mealMeasure1,
        equals(expectedResult.data?.mealMeasure1),
      );
      expect(
        successResult.data?.mealMeasure2,
        equals(expectedResult.data?.mealMeasure2),
      );
      expect(
        successResult.data?.mealMeasure3,
        equals(expectedResult.data?.mealMeasure3),
      );
      expect(
        successResult.data?.mealMeasure4,
        equals(expectedResult.data?.mealMeasure4),
      );
      expect(
        successResult.data?.mealMeasure5,
        equals(expectedResult.data?.mealMeasure5),
      );
      verify(
        mockedMealDetailsRepository.getMealDetails(mealId: anyNamed("mealId")),
      ).called(1);
    },
  );
}
