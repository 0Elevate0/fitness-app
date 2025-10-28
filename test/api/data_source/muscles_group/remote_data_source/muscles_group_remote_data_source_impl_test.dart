import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/muscles_group/remote_data_source/muscles_group_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/muscle_group/muscle_group_model.dart';
import 'package:fitness_app/api/responses/all_muscles_group_response/all_muscles_group_response.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscles_group_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity, SharedPreferencesHelper])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getAllMusclesGroup it should be called successfully from apiClient and returns a List of MuscleGroupEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      final mockedSharedPreferencesHelper = MockSharedPreferencesHelper();
      ConnectionManager.connectivity = mockedConnectivity;
      final musclesGroupRemoteDataSourceImpl = MusclesGroupRemoteDataSourceImpl(
        mockApiClient,
        mockedSharedPreferencesHelper,
      );
      final expectedMuscleGroupModelList = [
        MuscleGroupModel(name: "shoulder", id: "1"),
        MuscleGroupModel(name: "triceps", id: "2"),
      ];
      final expectedResponse = AllMusclesGroupResponse(
        message: "success",
        musclesGroup: expectedMuscleGroupModelList,
      );
      final expectedMuscleGroupEntityList =
          expectedResponse.musclesGroup
              ?.map((muscle) => muscle.toMuscleGroupEntity())
              .toList() ??
          [];
      final expectedResult = Success<List<MuscleGroupEntity>>(
        expectedMuscleGroupEntityList,
      );
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.register(request: anyNamed("request")),
      ).thenAnswer((_) async {});
      when(
        mockedSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage),
      ).thenReturn(false);
      when(
        mockApiClient.getAllMusclesGroup(
          currentLanguage: anyNamed("currentLanguage"),
        ),
      ).thenAnswer((_) async => expectedResponse);
      provideDummy<Result<List<MuscleGroupEntity>>>(expectedResult);

      // Act
      final result = await musclesGroupRemoteDataSourceImpl
          .getAllMusclesGroup();

      // Assert
      expect(result, isA<Success<List<MuscleGroupEntity>>>());
      final successResult = result as Success<List<MuscleGroupEntity>>;
      expect(successResult.data, equals(expectedMuscleGroupEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMuscleGroupEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMuscleGroupEntityList.elementAt(1)),
      );
      verify(
        mockApiClient.getAllMusclesGroup(
          currentLanguage: anyNamed("currentLanguage"),
        ),
      ).called(1);
    },
  );
}
