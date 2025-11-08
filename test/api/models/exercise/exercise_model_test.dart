import 'package:fitness_app/api/models/exercise/exercise_model.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ExercisesModel → ExerciseEntity", () {
    test(
      "when call toExerciseEntity with null values it should return ExerciseEntity with null values",
          () {
        // Arrange
        final ExercisesModel exercisesModel = ExercisesModel(
          id: null,
          exercise: null,
          difficultyLevel: null,
          primeMoverMuscle: null,
          primaryEquipment: null,
          bodyRegion: null,
          shortYoutubeDemonstrationLink: null,
        );

        // Act
        final ExerciseEntity actualResult =
        exercisesModel.toExerciseEntity();

        // Assert
        expect(actualResult.id, equals(exercisesModel.id));
        expect(actualResult.exercise, equals(exercisesModel.exercise));
        expect(actualResult.difficultyLevel, equals(exercisesModel.difficultyLevel));
        expect(actualResult.primeMoverMuscle, equals(exercisesModel.primeMoverMuscle));
        expect(actualResult.primaryEquipment, equals(exercisesModel.primaryEquipment));
        expect(actualResult.bodyRegion, equals(exercisesModel.bodyRegion));
        expect(actualResult.shortYoutubeDemonstrationLink,
            equals(exercisesModel.shortYoutubeDemonstrationLink));
      },
    );

    test(
      "when call toExerciseEntity with non-null values it should return ExerciseEntity with correct values",
          () {
        // Arrange
        final ExercisesModel exercisesModel = ExercisesModel(
          id: "1",
          exercise: "Push Up",
          difficultyLevel: "Beginner",
          primeMoverMuscle: "Chest",
          primaryEquipment: "Bodyweight",
          bodyRegion: "Upper Body",
          shortYoutubeDemonstrationLink: "https://youtu.be/pushup",
        );

        // Act
        final ExerciseEntity actualResult =
        exercisesModel.toExerciseEntity();

        // Assert
        expect(actualResult.id, equals(exercisesModel.id));
        expect(actualResult.exercise, equals(exercisesModel.exercise));
        expect(actualResult.difficultyLevel, equals(exercisesModel.difficultyLevel));
        expect(actualResult.primeMoverMuscle, equals(exercisesModel.primeMoverMuscle));
        expect(actualResult.primaryEquipment, equals(exercisesModel.primaryEquipment));
        expect(actualResult.bodyRegion, equals(exercisesModel.bodyRegion));
        expect(actualResult.shortYoutubeDemonstrationLink,
            equals(exercisesModel.shortYoutubeDemonstrationLink));
      },
    );
  });
}
