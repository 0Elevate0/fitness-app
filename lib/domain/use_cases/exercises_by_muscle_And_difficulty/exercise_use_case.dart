import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/repositories/exercises_by_muscle_And_difficulty/exercises_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExerciseUseCase {
  final ExercisesRepository _exercisesRepository;

  const ExerciseUseCase(this._exercisesRepository);

  Future<Result<List<ExerciseEntity>>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _exercisesRepository.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
