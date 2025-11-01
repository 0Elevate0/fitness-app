import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/meal_details/remote_data_source/meal_details_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/meal_details/meal_details_model.dart';
import 'package:fitness_app/api/responses/meal_details_response/meal_details_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getMealDetails it should be called successfully from apiClient and returns a MealDetailsEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final mealDetailsRemoteDataSourceImpl = MealDetailsRemoteDataSourceImpl(
        mockApiClient,
      );
      final chickenMealDetails = MealDetailsModel(
        idMeal: "52772",
        strMeal: "Teriyaki Chicken Casserole",
        strCategory: "Chicken",
        strArea: "Japanese",
        strInstructions:
            "Preheat oven to 350°F. Cook chicken in a pan until browned. Combine with teriyaki sauce, vegetables, and rice, then bake for 30 minutes.",
        strMealThumb: "chickenImage",
        strTags: "Meat,Casserole,MainCourse",
        strYoutube: "youtube link",
        strIngredient1: "soy sauce",
        strIngredient2: "water",
        strIngredient3: "brown sugar",
        strIngredient4: "ground ginger",
        strIngredient5: "minced garlic",
        strIngredient6: "cornstarch",
        strIngredient7: "chicken breasts",
        strIngredient8: "stir-fry vegetables",
        strIngredient9: "brown rice",
        strMeasure1: "3/4 cup",
        strMeasure2: "1/2 cup",
        strMeasure3: "1/4 cup",
        strMeasure4: "1/2 teaspoon",
        strMeasure5: "1 teaspoon",
        strMeasure6: "2 tablespoons",
        strMeasure7: "2",
        strMeasure8: "1 (12 oz.) bag",
        strMeasure9: "3 cups",
        strSource: "someLink",
      );
      final expectedResponse = MealDetailsResponse(meals: [chickenMealDetails]);
      final expectedChickenMealDetailsEntity = expectedResponse.meals?.first
          .toMealDetailsEntity();
      final expectedResult = Success<MealDetailsEntity?>(
        expectedChickenMealDetailsEntity,
      );
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      provideDummy<Result<MealDetailsEntity?>>(expectedResult);
      when(
        mockApiClient.getMealDetails(mealId: anyNamed("mealId")),
      ).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await mealDetailsRemoteDataSourceImpl.getMealDetails(
        mealId: "1234",
      );

      // Assert
      expect(result, isA<Success<MealDetailsEntity?>>());
      final successResult = result as Success<MealDetailsEntity?>;
      expect(successResult.data, equals(expectedChickenMealDetailsEntity));
      expect(
        successResult.data?.mealId,
        equals(expectedChickenMealDetailsEntity?.mealId),
      );
      expect(
        successResult.data?.mealTitle,
        equals(expectedChickenMealDetailsEntity?.mealTitle),
      );
      expect(
        successResult.data?.mealIngredient1,
        equals(expectedChickenMealDetailsEntity?.mealIngredient1),
      );
      expect(
        successResult.data?.mealIngredient2,
        equals(expectedChickenMealDetailsEntity?.mealIngredient2),
      );
      expect(
        successResult.data?.mealIngredient3,
        equals(expectedChickenMealDetailsEntity?.mealIngredient3),
      );
      verify(
        mockApiClient.getMealDetails(mealId: anyNamed("mealId")),
      ).called(1);
    },
  );
}
