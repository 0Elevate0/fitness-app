import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/recommendation_random_muscles/remote_data_source/recommendation_random_muscles_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/muscle/muscle_model.dart';
import 'package:fitness_app/api/responses/muscles_recommendation_response/muscles_recommendation_response.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_random_muscles_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity, SharedPreferencesHelper])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getRecommendationTodayMuscles it should be called successfully from apiClient and returns a List of MuscleEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      final mockedSharedPreferencesHelper = MockSharedPreferencesHelper();
      ConnectionManager.connectivity = mockedConnectivity;
      final recommendationRandomMusclesRemoteDataSourceImpl =
          RecommendationRandomMusclesRemoteDataSourceImpl(
            mockApiClient,
            mockedSharedPreferencesHelper,
          );
      final expectedMuscleModelList = [
        MuscleModel(image: "shoulder image", name: "shoulder", id: "1"),
        MuscleModel(image: "triceps image", name: "triceps", id: "2"),
      ];
      final expectedResponse = MusclesRecommendationResponse(
        message: "success",
        muscles: expectedMuscleModelList,
        totalMuscles: 2,
      );
      final expectedMuscleEntityList =
          expectedResponse.muscles
              ?.map((muscle) => muscle.toMuscleEntity())
              .toList() ??
          [];
      final expectedResult = Success<List<MuscleEntity>>(
        expectedMuscleEntityList,
      );
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockedSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage),
      ).thenReturn(false);
      when(
        mockApiClient.getRecommendationTodayMuscles(
          currentLanguage: anyNamed("currentLanguage"),
        ),
      ).thenAnswer((_) async => expectedResponse);
      provideDummy<Result<List<MuscleEntity>>>(expectedResult);

      // Act
      final result = await recommendationRandomMusclesRemoteDataSourceImpl
          .getRecommendationRandomMuscles();

      // Assert
      expect(result, isA<Success<List<MuscleEntity>>>());
      final successResult = result as Success<List<MuscleEntity>>;
      expect(successResult.data, equals(expectedMuscleEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMuscleEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMuscleEntityList.elementAt(1)),
      );
      verify(
        mockApiClient.getRecommendationTodayMuscles(
          currentLanguage: anyNamed("currentLanguage"),
        ),
      ).called(1);
    },
  );
}
