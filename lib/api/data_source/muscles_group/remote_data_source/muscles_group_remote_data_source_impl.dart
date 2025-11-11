import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/data/data_source/muscles_group/remote_data_source/muscles_group_remote_data_source.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MusclesGroupRemoteDataSource)
final class MusclesGroupRemoteDataSourceImpl
    implements MusclesGroupRemoteDataSource {
  final ApiClient _apiClient;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  const MusclesGroupRemoteDataSourceImpl(
    this._apiClient,
    this._sharedPreferencesHelper,
  );

  @override
  Future<Result<List<MuscleGroupEntity>>> getAllMusclesGroup() async {
    return await executeApi(() async {
      final bool isArabic = _sharedPreferencesHelper.getBool(
        key: ConstKeys.isArLanguage,
      );
      final response = await _apiClient.getAllMusclesGroup(
        currentLanguage: FitnessMethodHelper.getCurrentLanguage(
          isArabicLanguage: isArabic,
        ),
      );
      final musclesGroupList =
          response.musclesGroup
              ?.map((group) => group.toMuscleGroupEntity())
              .toList() ??
          [];
      return musclesGroupList;
    });
  }
}
