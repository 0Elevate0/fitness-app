import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/muscles_by_muscle_group/muscles_by_muscle_group_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllMusclesByMuscleGroupUseCase {
  final MusclesByMuscleGroupRepository _musclesByMuscleGroupRepository;
  const GetAllMusclesByMuscleGroupUseCase(this._musclesByMuscleGroupRepository);

  Future<Result<List<MuscleEntity>>> invoke({
    required String muscleGroupId,
  }) async {
    return await _musclesByMuscleGroupRepository.getAllMusclesByMuscleGroup(
      muscleGroupId: muscleGroupId,
    );
  }
}
