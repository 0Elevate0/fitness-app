import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/domain/repositories/verification/verification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerificationUseCase{
  final VerificationRepository _verificationRepository;
  const VerificationUseCase(this._verificationRepository);
  Future<Result<VerificationResponse>>call({required VerificationRequestEntity request}){
    return _verificationRepository.verificationCode(request: request);
  }
}



