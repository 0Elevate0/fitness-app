import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/forget_password/forget_password_repository.dart';
import 'package:fitness_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  test('when call call it should be called successfully from ForgetPasswordRepository',() async {
    final mockForgetPasswordRepository = MockForgetPasswordRepository();
    final forgetPasswordUseCase = ForgetPasswordUseCase(
      mockForgetPasswordRepository,
    );
    final requestEntity = const ForgetPasswordRequestEntity(
      email: "peterrafek36@gmail.com",
    );
    final forgetPasswordResponse = ForgetPasswordResponse(
      message: "message",
      info: "info",
    );
    final expectedResponse = forgetPasswordResponse;
    provideDummy<Result<ForgetPasswordResponse>>(Success(expectedResponse));
    final expectedResult = Success<ForgetPasswordResponse>(expectedResponse);
    when(
      mockForgetPasswordRepository.forgetPassword(request: requestEntity),
    ).thenAnswer((_) async => expectedResult);

    final result = await forgetPasswordUseCase.call(requestEntity);

    expect(result, isA<Success<ForgetPasswordResponse>>());
    verify(
      mockForgetPasswordRepository.forgetPassword(request: requestEntity),
    ).called(1);
  });
}
