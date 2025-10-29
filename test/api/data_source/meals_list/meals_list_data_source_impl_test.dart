import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/meals_list/meals_list_data_source_impl.dart';
import 'package:fitness_app/api/models/meals/meals_model.dart';
import 'package:fitness_app/api/responses/meals_list_response/meals_list_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_list_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call mealsList it should be called successfully from apiClient',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final mealsListDataSource = MealsListDataSourceImpl(mockApiClient);

      final expectedResponse = MealsListResponse(
        meals: [MealsModel(idMeal: '1', strMeal: 'chicken', strMealThumb: '')],
      );
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.getMealsByCategory('beef'),
      ).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await mealsListDataSource.getMealsByCategory('beef');

      // Assert
      expect(result, isA<Success<void>>());
      verify(mockApiClient.getMealsByCategory('beef')).called(1);
    },
  );
}
