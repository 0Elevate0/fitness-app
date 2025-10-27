import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/data/data_source/muscles_by_muscle_group/remote_data_source/muscles_by_muscle_group_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MusclesByMuscleGroupRemoteDataSource)
final class MusclesByMuscleGroupRemoteDataSourceImpl
    implements MusclesByMuscleGroupRemoteDataSource {
  final ApiClient _apiClient;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const MusclesByMuscleGroupRemoteDataSourceImpl(
    this._apiClient,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<List<MuscleEntity>>> getAllMusclesByMuscleGroup({
    required String muscleGroupId,
  }) async {
    return await executeApi(() async {
      final bool isArabic = _sharedPreferencesHelper.getBool(
        key: ConstKeys.isArLanguage,
      );
      final response = await _apiClient.getAllMusclesByMuscleGroup(
        currentLanguage: FitnessMethodHelper.getCurrentLanguage(
          isArabicLanguage: isArabic,
        ),
        muscleGroupId: muscleGroupId,
      );
      final musclesList =
          response.muscles?.map((muscle) => muscle.toMuscleEntity()).toList() ??
          [];
      return musclesList;
    });
  }
}
