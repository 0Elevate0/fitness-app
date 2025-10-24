import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRemoteDataSource)
final class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiClient _apiClient;
  const RegisterRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> register({
    required RegisterRequestEntity request,
  }) async {
    return await executeApi(() async {
      return await _apiClient.register(
        request: RequestMapper.toRegisterRequestModel(registerRequest: request),
      );
    });
  }
}
