import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/muscles_by_muscle_group/remote_data_source/muscles_by_muscle_group_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/muscle/muscle_model.dart';
import 'package:fitness_app/api/responses/all_muscles_by_muscle_group_response/all_muscles_by_muscle_group_response.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscles_by_muscle_group_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity, SharedPreferencesHelper])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesByMuscleGroup it should be called successfully from apiClient and returns a List of MuscleEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      final mockedSharedPreferencesHelper = MockSharedPreferencesHelper();
      ConnectionManager.connectivity = mockedConnectivity;
      final musclesByMuscleGroupRemoteDataSourceImpl =
          MusclesByMuscleGroupRemoteDataSourceImpl(
            mockApiClient,
            mockedSharedPreferencesHelper,
          );
      final expectedMuscleModelList = [
        MuscleModel(image: "shoulder image", name: "shoulder", id: "1"),
        MuscleModel(image: "triceps image", name: "triceps", id: "2"),
      ];
      final expectedResponse = AllMusclesByMuscleGroupResponse(
        message: "success",
        muscles: expectedMuscleModelList,
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
        mockApiClient.getAllMusclesByMuscleGroup(
          currentLanguage: anyNamed("currentLanguage"),
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).thenAnswer((_) async => expectedResponse);
      provideDummy<Result<List<MuscleEntity>>>(expectedResult);

      // Act
      final result = await musclesByMuscleGroupRemoteDataSourceImpl
          .getAllMusclesByMuscleGroup(muscleGroupId: "1234");

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
        mockApiClient.getAllMusclesByMuscleGroup(
          currentLanguage: anyNamed("currentLanguage"),
          muscleGroupId: anyNamed("muscleGroupId"),
        ),
      ).called(1);
    },
  );
}
