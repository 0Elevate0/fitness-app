import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/recommendation_random_muscles/recommendation_random_muscles_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRecommendationRandomMusclesUseCase {
  final RecommendationRandomMusclesRepository
  _recommendationRandomMusclesRepository;
  const GetRecommendationRandomMusclesUseCase(
    this._recommendationRandomMusclesRepository,
  );

  Future<Result<List<MuscleEntity>>> invoke() async {
    return await _recommendationRandomMusclesRepository
        .getRecommendationRandomMuscles();
  }
}
