import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:fitness_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSource)
final class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;

  const LoginRemoteDataSourceImpl(this._apiClient, this._secureStorage);

  @override
  Future<Result<void>> login({required LoginRequestEntity request}) async {
    return await executeApi(() async {
      final response = await _apiClient.login(
        request: RequestMapper.toLoginRequestModel(loginRequestEntity: request),
      );
      await _secureStorage.saveUserToken(token: response.token);
      FitnessMethodHelper.currentUserToken = response.token;
    });
  }
}
