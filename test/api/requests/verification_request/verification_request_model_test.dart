
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/api/requests/verification_request/verification_request_model.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toModel with null values it should return null values', () {
    final VerificationRequestEntity entity =
    const VerificationRequestEntity(resetCode: '');
    final VerificationRequestModel model =
    RequestMapper.toVerificationRequestModel(
        verificationRequestEntity: entity) ;
    expect(model.resetCode, '');

  });
  test(
    'when call toModel with non-null values it should return right values',
        () {
      final VerificationRequestEntity entity =
      const VerificationRequestEntity(
        resetCode: '123456',
      );
      final VerificationRequestModel model =
      RequestMapper.toVerificationRequestModel(
        verificationRequestEntity: entity,
      );
      expect(model.resetCode, equals(entity.resetCode));
    },
  );
}