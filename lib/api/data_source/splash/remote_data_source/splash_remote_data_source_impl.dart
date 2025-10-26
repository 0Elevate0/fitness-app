import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashRemoteDataSource)
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final ApiClient _apiClient;
  const SplashRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> getUserData() async {
    return executeApi(() async {
      final response = await _apiClient.getUserData(
        token: "Bearer ${FitnessMethodHelper.currentUserToken}",
      );
      final userData = response.user?.toUserDataEntity();
      FitnessMethodHelper.userData = userData;
    });
  }
}
