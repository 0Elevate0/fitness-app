import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/exercises_by_muscle_And_difficulty/remote_data_source/exercises_remote_data_source.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/repositories/exercises_by_muscle_And_difficulty/exercises_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:ExercisesRepository )
class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExercisesRemoteDataSource _exercisesRemoteDataSource;

  const ExercisesRepositoryImpl(this._exercisesRemoteDataSource);

  @override
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _exercisesRemoteDataSource.getExercisesByMuscleAndDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
