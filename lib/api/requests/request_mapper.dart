import 'package:fitness_app/api/requests/register_request/register_request_model.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';

import 'package:fitness_app/api/requests/login_request/login_request_model.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';

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
}
