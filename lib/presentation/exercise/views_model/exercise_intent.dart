import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';

sealed class ExerciseIntent {
  const ExerciseIntent();
}

final class ExerciseInitIntent extends ExerciseIntent {
  final ExerciseArgument exerciseArgument;

  const ExerciseInitIntent({required this.exerciseArgument});
}

final class ChangeExerciseLevelIntent extends ExerciseIntent {
  final DifficultyLevelEntity difficultyLevelId;
  final MuscleEntity primeMoverMuscle;

  const ChangeExerciseLevelIntent({
    required this.primeMoverMuscle,
    required this.difficultyLevelId,
  });
}

final class PlayVideoIntent extends ExerciseIntent {
  final ExerciseEntity exercise;
  const PlayVideoIntent({required this.exercise});
}

final class StopVideoIntent extends ExerciseIntent {
  const StopVideoIntent();
}
