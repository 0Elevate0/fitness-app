import 'package:fitness_app/api/requests/login_request/login_request_model.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract final class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }
}
