import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';

abstract interface class VerificationRemoteDataSource {
  Future<Result<VerificationResponse>> verificationCode({ required VerificationRequestEntity request,});
}
