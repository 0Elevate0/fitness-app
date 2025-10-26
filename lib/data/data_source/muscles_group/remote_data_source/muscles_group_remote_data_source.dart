import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';

abstract interface class MusclesGroupRemoteDataSource {
  Future<Result<List<MuscleGroupEntity>>> getAllMusclesGroup();
}
