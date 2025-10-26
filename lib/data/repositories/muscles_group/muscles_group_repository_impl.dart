import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/muscles_group/remote_data_source/muscles_group_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_group/muscles_group_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MusclesGroupRepository)
final class MusclesGroupRepositoryImpl implements MusclesGroupRepository {
  final MusclesGroupRemoteDataSource _musclesGroupRemoteDataSource;
  const MusclesGroupRepositoryImpl(this._musclesGroupRemoteDataSource);

  @override
  Future<Result<List<MuscleGroupEntity>>> getAllMusclesGroup() async {
    return await _musclesGroupRemoteDataSource.getAllMusclesGroup();
  }
}
