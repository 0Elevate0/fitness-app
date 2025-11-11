import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/repositories/difficult_levels_by_prime_mover/difficult_levels_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DifficultLevelsUseCase {
  final DifficultLevelsRepository _difficultLevelsRepository;

  const DifficultLevelsUseCase(this._difficultLevelsRepository);

  Future<Result<List<DifficultyLevelEntity>>> call(
      {required String primeMoverMuscleId}) {
    return _difficultLevelsRepository.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: primeMoverMuscleId);
  }
}