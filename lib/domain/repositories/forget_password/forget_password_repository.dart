import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';

abstract interface class ForgetPasswordRepository {
  Future<Result<ForgetPasswordResponse>> forgetPassword({
    required ForgetPasswordRequestEntity request,
  });
}
