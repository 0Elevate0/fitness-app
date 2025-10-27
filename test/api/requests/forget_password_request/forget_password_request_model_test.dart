import 'package:fitness_app/api/requests/forget_password_request/forget_password_request_model.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toModel with null values it should return null values', () {
    final ForgetPasswordRequestEntity entity =
    const ForgetPasswordRequestEntity(email: '');
    final ForgetPasswordRequestModel model =
    RequestMapper.toForgetPasswordRequestModel(
      forgetPasswordRequestEntity: entity,
    );
    expect(model.email, '');

  });
  test(
    'when call toModel with non-null values it should return right values',
        () {
      final ForgetPasswordRequestEntity entity =
      const ForgetPasswordRequestEntity(
        email: 'peterrafek36@gmail.com',
      );
      final ForgetPasswordRequestModel model =
      RequestMapper.toForgetPasswordRequestModel(
        forgetPasswordRequestEntity: entity,
      );
      expect(model.email, equals(entity.email));
    },
  );
}



