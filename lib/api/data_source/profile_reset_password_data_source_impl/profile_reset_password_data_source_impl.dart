import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:fitness_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileResetPasswordDataSource)
class ProfileResetPasswordDataSourceImpl
    implements ProfileResetPasswordDataSource {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;

  const ProfileResetPasswordDataSourceImpl(
    this._apiClient,
    this._secureStorage,
  );

  @override
  Future<Result<void>> profileResetPassword({
    required ProfileResetPasswordRequestEntity request,
  }) async {
    return executeApi(() async {
      final res = await _apiClient.profileResetPassword(
        token: "Bearer ${FitnessMethodHelper.currentUserToken}",
        request: RequestMapper.toProfileResetPasswordRequest(entity: request),
      );
      await _secureStorage.saveUserToken(token: res.token);
      FitnessMethodHelper.currentUserToken = res.token;
    });
  }
}
