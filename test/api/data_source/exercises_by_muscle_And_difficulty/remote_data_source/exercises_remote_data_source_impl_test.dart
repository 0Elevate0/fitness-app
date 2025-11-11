import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/exercises_by_muscle_And_difficulty/remote_data_source/exercises_remote_data_source_impl.dart';
import 'package:fitness_app/api/models/exercise/exercise_model.dart';
import 'package:fitness_app/api/responses/exercises_response/exercises_response.dart';
import 'package:fitness_app/core/connection_manager/connection_manager.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../presentation/onboarding/views_model/onboarding_cubit_test.mocks.dart';
import 'exercises_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, SharedPreferences, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    '  Implement tests for exercises_remote_data_source_impl.dart',
    () async {
      final mockApiClient = MockApiClient();
      final mockedSharedPreferencesHelper = MockSharedPreferencesHelper();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final dataSource = ExercisesRemoteDaraSourceImpl(
        mockApiClient,
        mockedSharedPreferencesHelper,
      );
      final expectedExerciseModelList = [
        ExercisesModel(
          id: "1",
          exercise: "Push Up",
          difficultyLevel: "Beginner",
          primeMoverMuscle: "Chest",
          primaryEquipment: "Bodyweight",
          bodyRegion: "Upper Body",
          shortYoutubeDemonstrationLink:
              "https://www.youtube.com/watch?v=IODxDxX7oi4",
        ),
        ExercisesModel(
          id: "2",
          exercise: "Squat",
          difficultyLevel: "Intermediate",
          primeMoverMuscle: "Quadriceps",
          primaryEquipment: "Barbell",
          bodyRegion: "Lower Body",
          shortYoutubeDemonstrationLink:
              "https://www.youtube.com/watch?v=aclHkVaku9U",
        ),
      ];
      final expectedResponse = ExercisesResponse(
        message: "success",
        exercises: expectedExerciseModelList,
      );
      final expectedExerciseEntityList =
          expectedResponse.exercises
              ?.map((exercise) => exercise.toExerciseEntity())
              .toList() ??
          [];
      final expectedResult = Success<List<ExerciseEntity>>(
        expectedExerciseEntityList,
      );
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      when(
        mockedSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage),
      ).thenReturn(false);
      when(
        mockApiClient.getExercisesByMuscleAndDifficulty(
          difficultyLevelId:"difficultyLevelId",
          primeMoverMuscleId:"primeMoverMuscleId",
          currentLanguage: anyNamed("currentLanguage"),
        ),
      ).thenAnswer((_) async => expectedResponse);
      provideDummy<Result<List<ExerciseEntity>>>(expectedResult);

      final result =await dataSource.getExercisesByMuscleAndDifficulty(
          primeMoverMuscleId: "primeMoverMuscleId",
          difficultyLevelId: "difficultyLevelId");

      expect(result,  isA<Success<List<ExerciseEntity>>>());
      final successResult = result as Success<List<ExerciseEntity>>;
      expect(successResult.data, equals(expectedExerciseEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedExerciseEntityList.elementAt(0)),
      );
          expect(
            successResult.data.elementAt(1),
            equals(expectedExerciseEntityList.elementAt(1)),
          );
          verify(
          mockApiClient.getExercisesByMuscleAndDifficulty(
          currentLanguage: anyNamed("currentLanguage"),
            primeMoverMuscleId: "primeMoverMuscleId", difficultyLevelId: "difficultyLevelId",
      ),
      ).called(1);
    },
  );
}
