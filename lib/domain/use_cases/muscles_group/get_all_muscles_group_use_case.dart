import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_group/muscles_group_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllMusclesGroupUseCase {
  final MusclesGroupRepository _musclesGroupRepository;
  const GetAllMusclesGroupUseCase(this._musclesGroupRepository);

  Future<Result<List<MuscleGroupEntity>>> invoke() async {
    return await _musclesGroupRepository.getAllMusclesGroup();
  }
}
