import 'package:fitness_app/api/models/exercise/exercise_model.dart';
import 'package:fitness_app/api/responses/exercises_response/exercises_response.dart';
import 'package:fitness_app/domain/use_cases/exercises_by_muscle_And_difficulty/exercise_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/repositories/exercises_by_muscle_And_difficulty/exercises_repository.dart';
 import 'exercise_use_case_test.mocks.dart';

@GenerateMocks([ExercisesRepository])
void main() {
  test('Implement tests for exercise_use_case.dart', () async {
    final mockRepository = MockExercisesRepository();
    final useCase = ExerciseUseCase(mockRepository);

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

    final expectedResult = Success<List<ExerciseEntity>>(expectedExerciseEntityList);

    provideDummy<Result<List<ExerciseEntity>>>(expectedResult);

    when(
      mockRepository.getExercisesByMuscleAndDifficulty(
        primeMoverMuscleId: "primeMoverMuscleId",
        difficultyLevelId: "difficultyLevelId",
      ),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase(
      primeMoverMuscleId: "primeMoverMuscleId",
      difficultyLevelId: "difficultyLevelId",
    );

    expect(result, isA<Success<List<ExerciseEntity>>>());
    final successResult = result as Success<List<ExerciseEntity>>;
    expect(successResult.data, equals(expectedExerciseEntityList));

    verify(
      mockRepository.getExercisesByMuscleAndDifficulty(
        primeMoverMuscleId: "primeMoverMuscleId",
        difficultyLevelId: "difficultyLevelId",
      ),
    ).called(1);
  });
}
