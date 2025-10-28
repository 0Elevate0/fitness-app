import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';

abstract interface class MusclesByMuscleGroupRemoteDataSource {
  Future<Result<List<MuscleEntity>>> getAllMusclesByMuscleGroup({
    required String muscleGroupId,
  });
}
