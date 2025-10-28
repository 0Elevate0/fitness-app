import 'package:fitness_app/api/models/muscle_group/muscle_group_model.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("MuscleGroupModel → MuscleGroupEntity", () {
    test(
      "when call toMuscleGroupEntity with null values it should return MuscleGroupEntity with null values",
      () {
        // Arrange
        final MuscleGroupModel muscleGroupModel = MuscleGroupModel(
          id: null,
          name: null,
        );

        // Act
        final MuscleGroupEntity actualResult = muscleGroupModel
            .toMuscleGroupEntity();

        // Assert
        expect(actualResult.id, equals(muscleGroupModel.id));
        expect(actualResult.name, equals(muscleGroupModel.name));
      },
    );

    test(
      "when call toMuscleGroupEntity with non-null values it should return MuscleGroupEntity with correct values",
      () {
        // Arrange
        final MuscleGroupModel muscleGroupModel = MuscleGroupModel(
          id: "1",
          name: "Chest",
        );

        // Act
        final MuscleGroupEntity actualResult = muscleGroupModel
            .toMuscleGroupEntity();

        // Assert
        expect(actualResult.id, equals(muscleGroupModel.id));
        expect(actualResult.name, equals(muscleGroupModel.name));
      },
    );
  });
}
