import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/data_source/difficult_levels_by_prime_mover/remote_data_source/difficult_levels_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/difficulty_levels/difficulty_levels_model.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/difficulty_levels_response/difficulty_levels_response.dart';
 import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
 import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'difficult_levels_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, SharedPreferencesHelper,Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Implement tests for difficult_levels_remote_data_source_impl.dart', () async {
    final mockApiClient = MockApiClient();
    final mockSharedPreferencesHelper = MockSharedPreferencesHelper();
    final mockedConnectivity = MockConnectivity();
    ConnectionManager.connectivity = mockedConnectivity;
    final dataSource = DifficultLevelRemoteDataSourceImpl(
      mockApiClient,
      mockSharedPreferencesHelper,
    );

    final expectedDifficultyLevelsModelList = [
      DifficultyLevelsModel(
        id: "1",
        name: "Beginner",
      ),
      DifficultyLevelsModel(
        id: "2",
        name: "Intermediate",
      ),
    ];
    final expectedResponse = DifficultyLevelsResponse(
      message: "success",
      difficultyLevels: expectedDifficultyLevelsModelList,
    );
    final expectedDifficultyLevelEntityList =
        expectedResponse.difficultyLevels
            ?.map((difficulty) => difficulty.toDifficultyLevelEntity())
            .toList() ??
            [];
    final expectedResult = Success<List<DifficultyLevelEntity>>(expectedDifficultyLevelEntityList);

    when(mockSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage))
        .thenReturn(false);
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);


    when(mockApiClient.getDifficultyLevelsByPrimeMover(
      currentLanguage: anyNamed('currentLanguage'),
      primeMoverMuscleId: 'primeMoverMuscleId',
    )).thenAnswer((_) async => expectedResponse);

    provideDummy<Result<List<DifficultyLevelEntity>>>(expectedResult);

    final result = await dataSource.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId: 'primeMoverMuscleId',
    );

    expect(result, isA<Success<List<DifficultyLevelEntity>>>());
    final successResult = result as Success<List<DifficultyLevelEntity>>;
    expect(successResult.data, equals(expectedDifficultyLevelEntityList));

    verify(mockApiClient.getDifficultyLevelsByPrimeMover(
      currentLanguage: anyNamed('currentLanguage'),
      primeMoverMuscleId: 'primeMoverMuscleId',
    )).called(1);
  });
}
