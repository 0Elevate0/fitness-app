import 'package:fitness_app/api/requests/forget_password_request/forget_password_request_model.dart';
import 'package:fitness_app/api/requests/reset_password_request/reset_password_request_model.dart';
import 'package:fitness_app/api/requests/verification_request/verification_request_model.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';

abstract final class RequestMapper {
  static ForgetPasswordRequestModel toForgetPasswordRequestModel({
    required ForgetPasswordRequestEntity forgetPasswordRequestEntity,
  }) {
    return ForgetPasswordRequestModel(email: forgetPasswordRequestEntity.email);
  }

  static VerificationRequestModel toVerificationRequestModel({
    required VerificationRequestEntity verificationRequestEntity,
  }) {
    return VerificationRequestModel(
      resetCode: verificationRequestEntity.resetCode,
    );
  }

  static ResetPasswordRequestModel toResetPasswordRequestModel({
    required ResetPasswordRequestEntity resetPasswordRequestEntity,
  }) {
    return ResetPasswordRequestModel(
      email: resetPasswordRequestEntity.email,
      newPassword: resetPasswordRequestEntity.newPassword,
    );
  }
}
