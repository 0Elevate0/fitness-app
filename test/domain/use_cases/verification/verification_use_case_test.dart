import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/domain/repositories/verification/verification_repository.dart';
import 'package:fitness_app/domain/use_cases/verification/verification_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_use_case_test.mocks.dart';

@GenerateMocks([VerificationRepository])
void main() {
  test(
    'when call call it should be called successfully from VerificationRepository',
    () async {
      final mockVerificationRepository = MockVerificationRepository();
      final verificationUseCase = VerificationUseCase(
        mockVerificationRepository,
      );
      final requestEntity = const VerificationRequestEntity(
        resetCode: "123456",
      );
      final verificationResponse = VerificationResponse(status: "status");
      final expectedResponse = verificationResponse;
      provideDummy<Result<VerificationResponse>>(Success(expectedResponse));
      final expectedResult = Success<VerificationResponse>(expectedResponse);
      when(
        mockVerificationRepository.verificationCode(request: requestEntity),
      ).thenAnswer((_) async => expectedResult);

      final result = await verificationUseCase.call(request: requestEntity);

      expect(result, isA<Success<VerificationResponse>>());
      verify(
        mockVerificationRepository.verificationCode(request: requestEntity),
      ).called(1);
    },
  );
}
