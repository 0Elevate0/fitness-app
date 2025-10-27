import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/data/data_source/recommendation_random_muscles/remote_data_source/recommendation_random_muscles_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecommendationRandomMusclesRemoteDataSource)
final class RecommendationRandomMusclesRemoteDataSourceImpl
    implements RecommendationRandomMusclesRemoteDataSource {
  final ApiClient _apiClient;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const RecommendationRandomMusclesRemoteDataSourceImpl(
    this._apiClient,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<List<MuscleEntity>>> getRecommendationRandomMuscles() async {
    return await executeApi(() async {
      final bool isArabic = _sharedPreferencesHelper.getBool(
        key: ConstKeys.isArLanguage,
      );
      final response = await _apiClient.getRecommendationTodayMuscles(
        currentLanguage: FitnessMethodHelper.getCurrentLanguage(
          isArabicLanguage: isArabic,
        ),
      );
      final musclesList =
          response.muscles?.map((muscle) => muscle.toMuscleEntity()).toList() ??
          [];
      return musclesList;
    });
  }
}
