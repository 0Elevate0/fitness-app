import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/difficult_levels_by_prime_mover/remote_data_source/difficult_levels_remote_data_source.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/repositories/difficult_levels_by_prime_mover/difficult_levels_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DifficultLevelsRepository)
class DifficultLevelsRepositoryImpl implements DifficultLevelsRepository {
  final DifficultLevelRemoteDataSource _difficultLevelRemoteDataSource;

  const DifficultLevelsRepositoryImpl(this._difficultLevelRemoteDataSource);

  @override
  Future<Result<List<DifficultyLevelEntity>>> getDifficultyLevelsByPrimeMover({
    required String primeMoverMuscleId,
  }) {
    return _difficultLevelRemoteDataSource.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId: primeMoverMuscleId,
    );
  }
}
