import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/data/data_source/difficult_levels_by_prime_mover/remote_data_source/difficult_levels_remote_data_source.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DifficultLevelRemoteDataSource)
class DifficultLevelRemoteDataSourceImpl
    implements DifficultLevelRemoteDataSource {
  final ApiClient _apiClient;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const DifficultLevelRemoteDataSourceImpl(
    this._apiClient,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<List<DifficultyLevelEntity>>> getDifficultyLevelsByPrimeMover({
    required String primeMoverMuscleId,
  }) async {
    return await executeApi(() async {
      final bool isArabic = _sharedPreferencesHelper.getBool(
        key: ConstKeys.isArLanguage,
      );
      final result = await _apiClient.getDifficultyLevelsByPrimeMover(
        currentLanguage: FitnessMethodHelper.getCurrentLanguage(
          isArabicLanguage: isArabic,
        ),
        primeMoverMuscleId: primeMoverMuscleId,
      );
      final difficultyLevelsList =
          result.difficultyLevels
              ?.map(
                (difficultyLevels) =>
                    difficultyLevels.toDifficultyLevelEntity(),
              )
              .toList() ??
          [];

      return difficultyLevelsList;
    });
  }
}
