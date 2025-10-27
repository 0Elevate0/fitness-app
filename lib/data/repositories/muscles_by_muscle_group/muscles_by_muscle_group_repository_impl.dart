import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/muscles_by_muscle_group/remote_data_source/muscles_by_muscle_group_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_by_muscle_group/muscles_by_muscle_group_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MusclesByMuscleGroupRepository)
final class MusclesByMuscleGroupRepositoryImpl
    implements MusclesByMuscleGroupRepository {
  final MusclesByMuscleGroupRemoteDataSource
  _musclesByMuscleGroupRemoteDataSource;
  const MusclesByMuscleGroupRepositoryImpl(
    this._musclesByMuscleGroupRemoteDataSource,
  );

  @override
  Future<Result<List<MuscleEntity>>> getAllMusclesByMuscleGroup({
    required String muscleGroupId,
  }) async {
    return await _musclesByMuscleGroupRemoteDataSource
        .getAllMusclesByMuscleGroup(muscleGroupId: muscleGroupId);
  }
}
