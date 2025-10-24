import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/data/data_source/verification/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:VerificationRepository )
class VerificationRepositoryImpl implements VerificationRepository{
  final VerificationRemoteDataSource _verificationRemoteDataSource;
  const VerificationRepositoryImpl(this._verificationRemoteDataSource);
  @override
  Future<Result<VerificationResponse>> verificationCode({required VerificationRequestEntity request}) {
    return _verificationRemoteDataSource.verificationCode(request: request);
  }
}