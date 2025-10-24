import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase{
  final ResetPasswordRepository _resetPasswordRepository;
  const ResetPasswordUseCase(this._resetPasswordRepository);
  Future<Result<ResetPasswordResponse>>call({required ResetPasswordRequestEntity request}){
    return _resetPasswordRepository.resetPassword(request: request);
  }
}