import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/api/requests/reset_password_request/reset_password_request_model.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toModel with null values it should return null values', () {
    final ResetPasswordRequestEntity entity =
    const ResetPasswordRequestEntity(email: '');
    final ResetPasswordRequestModel model =
    RequestMapper.toResetPasswordRequestModel(
      resetPasswordRequestEntity: entity,
    );
    expect(model.email, '');

  });
  test(
    'when call toModel with non-null values it should return right values',
        () {
      final ResetPasswordRequestEntity entity =
      const ResetPasswordRequestEntity(
        email: 'peterrafek36@gmail.com',
      );
      final ResetPasswordRequestModel model =
      RequestMapper.toResetPasswordRequestModel(
        resetPasswordRequestEntity: entity,
      );
      expect(model.email, equals(entity.email));
    },
  );
}


















