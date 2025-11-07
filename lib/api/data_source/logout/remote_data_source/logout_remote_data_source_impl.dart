import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:fitness_app/data/data_source/logout/remote_data_source/logout_remote_data_source.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRemoteDataSource)
final class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;
  const LogoutRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  @override
  Future<Result<void>> logout() async {
    return executeApi(() async {
      await _apiClient.logout(
        token: "Bearer ${FitnessMethodHelper.currentUserToken}",
      );
      await _secureStorage.deleteData(key: ConstKeys.tokenKey);
      FitnessMethodHelper.currentUserToken = null;
      FitnessMethodHelper.userData = null;
    });
  }
}
