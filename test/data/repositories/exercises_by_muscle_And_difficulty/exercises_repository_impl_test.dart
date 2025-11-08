import 'package:fitness_app/api/models/exercise/exercise_model.dart';
import 'package:fitness_app/api/responses/exercises_response/exercises_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/exercises_by_muscle_And_difficulty/remote_data_source/exercises_remote_data_source.dart';
import 'package:fitness_app/data/repositories/exercises_by_muscle_And_difficulty/exercises_repository_impl.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'exercises_repository_impl_test.mocks.dart';

@GenerateMocks([ExercisesRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Implement tests for exercises_repository_impl.dart', () async {
    final mockRemoteDataSource = MockExercisesRemoteDataSource();
    final repository = ExercisesRepositoryImpl(mockRemoteDataSource);

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
    provideDummy<Result<List<ExerciseEntity>>>(expectedResult);

    when(
      mockRemoteDataSource.getExercisesByMuscleAndDifficulty(
        primeMoverMuscleId: "primeMoverMuscleId",
        difficultyLevelId: "difficultyLevelId",
      ),
    ).thenAnswer((_) async => expectedResult);

    final result = await repository.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: "primeMoverMuscleId",
      difficultyLevelId: "difficultyLevelId",
    );

    expect(result, isA<Success<List<ExerciseEntity>>>());
    final successResult = result as Success<List<ExerciseEntity>>;
    expect(successResult.data, equals(expectedExerciseEntityList));

    verify(
      mockRemoteDataSource.getExercisesByMuscleAndDifficulty(
        primeMoverMuscleId: "primeMoverMuscleId",
        difficultyLevelId: "difficultyLevelId",
      ),
    ).called(1);
  });
}
