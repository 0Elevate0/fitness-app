import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';

abstract interface class DifficultLevelsRepository {
  Future<Result<List<DifficultyLevelEntity>>> getDifficultyLevelsByPrimeMover({
    required String primeMoverMuscleId,
  });
}
