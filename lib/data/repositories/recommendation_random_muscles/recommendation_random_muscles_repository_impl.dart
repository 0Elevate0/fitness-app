import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/recommendation_random_muscles/remote_data_source/recommendation_random_muscles_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/recommendation_random_muscles/recommendation_random_muscles_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecommendationRandomMusclesRepository)
final class RecommendationRandomMusclesRepositoryImpl
    implements RecommendationRandomMusclesRepository {
  final RecommendationRandomMusclesRemoteDataSource
  _recommendationRandomMusclesRemoteDataSource;
  const RecommendationRandomMusclesRepositoryImpl(
    this._recommendationRandomMusclesRemoteDataSource,
  );

  @override
  Future<Result<List<MuscleEntity>>> getRecommendationRandomMuscles() async {
    return await _recommendationRandomMusclesRemoteDataSource
        .getRecommendationRandomMuscles();
  }
}
