import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/meals_categories/remote_data_source/meals_categories_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/meal_category/meal_category_model.dart';
import 'package:fitness_app/api/responses/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_categories_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMealsCategories it should be called successfully from apiClient and returns a List of MealCategoryEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final MealsCategoriesRemoteDataSourceImpl
      mealsCategoriesRemoteDataSourceImpl = MealsCategoriesRemoteDataSourceImpl(
        mockApiClient,
      );
      final expectedMealCategoryModelList = [
        MealCategoryModel(
          idCategory: "1",
          strCategory: "Beef",
          strCategoryThumb:
              "https://www.themealdb.com/images/category/beef.png",
          strCategoryDescription:
              "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
        ),
        MealCategoryModel(
          idCategory: "2",
          strCategory: "Chicken",
          strCategoryThumb:
              "https://www.themealdb.com/images/category/chicken.png",
          strCategoryDescription:
              "Chicken is one of the most common types of poultry in the world, known for its versatility in cooking.",
        ),
      ];
      final expectedResponse = MealsCategoriesResponse(
        categories: expectedMealCategoryModelList,
      );
      final expectedMealCategoryEntityList =
          expectedResponse.categories
              ?.map((mealCategory) => mealCategory.toMealCategoryEntity())
              .toList() ??
          [];
      final expectedResult = Success<List<MealCategoryEntity>>(
        expectedMealCategoryEntityList,
      );
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.getAllMealsCategories(),
      ).thenAnswer((_) async => expectedResponse);
      provideDummy<Result<List<MealCategoryEntity>>>(expectedResult);

      // Act
      final result = await mealsCategoriesRemoteDataSourceImpl
          .getAllMealsCategories();

      // Assert
      expect(result, isA<Success<List<MealCategoryEntity>>>());
      final successResult = result as Success<List<MealCategoryEntity>>;
      expect(successResult.data, equals(expectedMealCategoryEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMealCategoryEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMealCategoryEntityList.elementAt(1)),
      );
      verify(mockApiClient.getAllMealsCategories()).called(1);
    },
  );
}
