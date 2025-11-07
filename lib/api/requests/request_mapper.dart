import 'package:fitness_app/api/requests/edit_profile_request/edit_profile_request_model.dart';
import 'package:fitness_app/api/requests/forget_password_request/forget_password_request_model.dart';
import 'package:fitness_app/api/requests/login_request/login_request_model.dart';
import 'package:fitness_app/api/requests/profile%20_reset_password/profile_reset_password_request.dart';
import 'package:fitness_app/api/requests/register_request/register_request_model.dart';
import 'package:fitness_app/api/requests/reset_password_request/reset_password_request_model.dart';
import 'package:fitness_app/api/requests/verification_request/verification_request_model.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';
import 'package:fitness_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';

abstract final class RequestMapper {
  static RegisterRequestModel toRegisterRequestModel({
    required RegisterRequestEntity registerRequest,
  }) {
    return RegisterRequestModel(
      firstName: registerRequest.firstName,
      lastName: registerRequest.lastName,
      email: registerRequest.email,
      password: registerRequest.password,
      rePassword: registerRequest.rePassword,
      gender: registerRequest.gender,
      height: registerRequest.height,
      weight: registerRequest.weight,
      age: registerRequest.age,
      goal: registerRequest.goal,
      activityLevel: registerRequest.activityLevel,
    );
  }

  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

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

  static ProfileResetPasswordRequestModel toProfileResetPasswordRequest({
    required ProfileResetPasswordRequestEntity entity,
  }) {
    return ProfileResetPasswordRequestModel(
      password: entity.password,
      newPassword: entity.newPassword,
    );
  }

  static EditProfileRequestModel toEditProfileRequestModel({
    required EditProfileRequestEntity request,
  }) {
    return EditProfileRequestModel(
      firstName: request.firstName,
      lastName: request.lastName,
      weight: request.weight,
      goal: request.goal,
      activityLevel: request.activityLevel,
    );
  }
}
