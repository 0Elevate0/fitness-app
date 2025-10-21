import 'package:fitness_app/api/requests/login_request/login_request_model.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'when call toModel with non-null values it should return right values',
    () {
      final LoginRequestEntity entity = const LoginRequestEntity(
        email: 'moaazhassan10@gmaikl.com',
        password: 'Password@123',
      );
      final LoginRequestModel model = RequestMapper.toLoginRequestModel(
        loginRequestEntity: entity,
      );
      expect(model.email, equals(entity.email));
      expect(model.password, equals(entity.password));
    },
  );
}
