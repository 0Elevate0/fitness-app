import 'package:fitness_app/api/models/difficulty_levels/difficulty_levels_model.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DifficultyLevelsModel → DifficultyLevelEntity", () {
    test(
      "when call toDifficultyLevelEntity with null values it should return DifficultyLevelEntity with null values",
          () {
        // Arrange
        final DifficultyLevelsModel difficultyLevelsModel = DifficultyLevelsModel(
          id: null,
          name: null,
        );

        // Act
        final DifficultyLevelEntity actualResult =
        difficultyLevelsModel.toDifficultyLevelEntity();

        // Assert
        expect(actualResult.id, equals(difficultyLevelsModel.id));
        expect(actualResult.name, equals(difficultyLevelsModel.name));
      },
    );

    test(
      "when call toDifficultyLevelEntity with non-null values it should return DifficultyLevelEntity with correct values",
          () {
        // Arrange
        final DifficultyLevelsModel difficultyLevelsModel = DifficultyLevelsModel(
          id: "1",
          name: "Beginner",
        );

        // Act
        final DifficultyLevelEntity actualResult =
        difficultyLevelsModel.toDifficultyLevelEntity();

        // Assert
        expect(actualResult.id, equals(difficultyLevelsModel.id));
        expect(actualResult.name, equals(difficultyLevelsModel.name));
      },
    );
  });
}
