import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';

abstract interface class ResetPasswordRepository{
  Future<Result<ResetPasswordResponse>>resetPassword({required ResetPasswordRequestEntity request});
}