import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/meals_by_category_datasource_impl/meals_by_category_datasource_impl.dart';
import 'package:fitness_app/api/responses/meals_by_category/meals_by_category_responce.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/domain/entities/meal_by_category/meal_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../login/remote_data_source/login_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    "when call getMealsByCategory it should be called successfully from apiClient and returns a List of MealEntity",
    () async {
      //arrange
      final MockApiClient mockApiClient = MockApiClient();
      final mokedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mokedConnectivity;
      final MealsByCategoryDataSourceImpl dataSourceImpl =
          MealsByCategoryDataSourceImpl(mockApiClient);
      final String categoryName = "pasta";
      final expectedMealsByCategoryList = MealsByCategory(
        meals: [
          Meals(
            idMeal: "1",
            strMeal: "pasta with alfredo",
            strMealThumb: "image1.png",
          ),
          Meals(
            idMeal: "2",
            strMeal: "pasta with chicken",
            strMealThumb: "image2.png",
          ),
        ],
      );
      final expectedMealEntityList =
          expectedMealsByCategoryList.meals
              ?.map((meals) => meals.toMealEntity())
              .toList() ??
          [];

      when(
        mokedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(
        mockApiClient.getMealsByCategory(categoryName: categoryName),
      ).thenAnswer((_) async => expectedMealsByCategoryList);
      //Act
      final result = await dataSourceImpl.getMealsByCategory(
        categoryName: categoryName,
      );
      //Assert
      expect(result, isA<Success<List<MealEntity>>>());
      final successResult = result as Success<List<MealEntity>>;
      expect(successResult.data, equals(expectedMealEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMealEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMealEntityList.elementAt(1)),
      );
      verify(
        mockApiClient.getMealsByCategory(categoryName: categoryName),
      ).called(1);
    },
  );
}
