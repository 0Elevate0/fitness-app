import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/data/data_source/reset_password/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {
  final ApiClient _apiClient;

  const ResetPasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequestEntity request,
  }) async {
    return executeApi(() async {
      final response = await _apiClient.resetPassword(
        request: RequestMapper.toResetPasswordRequestModel(
          resetPasswordRequestEntity: request,
        ),
      );
      return response;
    });
  }
}
