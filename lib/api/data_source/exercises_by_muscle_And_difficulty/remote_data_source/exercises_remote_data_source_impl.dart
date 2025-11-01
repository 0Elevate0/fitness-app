import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/data/data_source/exercises_by_muscle_And_difficulty/remote_data_source/exercises_remote_data_source.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExercisesRemoteDataSource)
class ExercisesRemoteDaraSourceImpl implements  ExercisesRemoteDataSource{
  final ApiClient _apiClient;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const ExercisesRemoteDaraSourceImpl(
    this._apiClient,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<List<ExerciseEntity>>> getExercisesByMuscleAndDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) async {
    return await executeApi(() async {
      final bool isArabic = _sharedPreferencesHelper.getBool(
        key: ConstKeys.isArLanguage,
      );
      final result = await _apiClient.getExercisesByMuscleAndDifficulty(
        currentLanguage: FitnessMethodHelper.getCurrentLanguage(
          isArabicLanguage: isArabic,
        ),
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
      );
      final exercisesList =
          result.exercises
              ?.map((exercise) => exercise.toExerciseEntity())
              .toList() ??
          [];
      return exercisesList;
    });
  }
}
