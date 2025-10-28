import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';

abstract interface class RecommendationRandomMusclesRemoteDataSource {
  Future<Result<List<MuscleEntity>>> getRecommendationRandomMuscles();
}
