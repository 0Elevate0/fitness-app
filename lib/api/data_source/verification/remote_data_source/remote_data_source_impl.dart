import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/data/data_source/verification/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: VerificationRemoteDataSource)
class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  final ApiClient _apiClient;

  const VerificationRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<VerificationResponse>> verificationCode({
    required VerificationRequestEntity request,
  }) async {
    return await executeApi(() async {
      final response = await _apiClient.verificationCode(
        request: RequestMapper.toVerificationRequestModel(
          verificationRequestEntity: request,
        ),
      );
      return response;
    });
  }
}
