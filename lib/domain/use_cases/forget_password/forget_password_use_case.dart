import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/forget_password/forget_password_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class ForgetPasswordUseCase{
  final ForgetPasswordRepository _forgetPasswordRepository;
  const ForgetPasswordUseCase(this._forgetPasswordRepository);
  Future<Result<ForgetPasswordResponse>>call(ForgetPasswordRequestEntity request){
    return _forgetPasswordRepository.forgetPassword(request: request);
  }
}