import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:fitness_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([ResetPasswordRepository])
void main() {
  test(
    'when call call it should be called successfully from ResetPasswordRepository',
    () async {
      final mockResetPasswordRepository = MockResetPasswordRepository();
      final resetPasswordUseCase = ResetPasswordUseCase(
        mockResetPasswordRepository,
      );
      final requestEntity = const ResetPasswordRequestEntity(
        email: "peterrafek36@gmail.com",
      );
      final resetPasswordResponse = ResetPasswordResponse(
        token: "token",
        message: "message",
      );
      final expectedResponse = resetPasswordResponse;
      provideDummy<Result<ResetPasswordResponse>>(Success(expectedResponse));
      final expectedResult = Success<ResetPasswordResponse>(expectedResponse);
      when(
        mockResetPasswordRepository.resetPassword(request: requestEntity),
      ).thenAnswer((_) async => expectedResult);

      final result = await resetPasswordUseCase.call(request: requestEntity);

      expect(result, isA<Success<ResetPasswordResponse>>());
      verify(
        mockResetPasswordRepository.resetPassword(request: requestEntity),
      ).called(1);
    },
  );
}
