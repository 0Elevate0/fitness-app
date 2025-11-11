import 'package:fitness_app/api/models/muscle/muscle_model.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MuscleModel → MuscleEntity", () {
    test(
      "when call toMuscleEntity with null values it should return MuscleEntity with null values",
      () {
        // Arrange
        final MuscleModel muscleModel = MuscleModel(
          id: null,
          name: null,
          image: null,
        );

        // Act
        final MuscleEntity actualResult = muscleModel.toMuscleEntity();

        // Assert
        expect(actualResult.id, equals(muscleModel.id));
        expect(actualResult.name, equals(muscleModel.name));
        expect(actualResult.image, equals(muscleModel.image));
      },
    );

    test(
      "when call toMuscleEntity with non-null values it should return MuscleEntity with correct values",
      () {
        // Arrange
        final MuscleModel muscleModel = MuscleModel(
          id: "1",
          name: "Biceps",
          image: "https://example.com/images/biceps.png",
        );

        // Act
        final MuscleEntity actualResult = muscleModel.toMuscleEntity();

        // Assert
        expect(actualResult.id, equals(muscleModel.id));
        expect(actualResult.name, equals(muscleModel.name));
        expect(actualResult.image, equals(muscleModel.image));
      },
    );
  });
}
