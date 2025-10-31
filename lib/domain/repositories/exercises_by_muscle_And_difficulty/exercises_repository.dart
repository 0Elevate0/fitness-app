import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';

abstract interface class ExercisesRepository {
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  });
}
