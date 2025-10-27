import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:fitness_app/domain/use_cases/verification/verification_use_case.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_intent.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'verification_cubit_test.mocks.dart';

@GenerateMocks([VerificationUseCase, ForgetPasswordUseCase])
void main() {
  late MockVerificationUseCase mockVerificationUseCase;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late VerificationCubit cubit;

  late Result<VerificationResponse> expectedVerifySuccess;
  late Result<ForgetPasswordResponse> expectedResendSuccess;
  late Failure<VerificationResponse> expectedVerifyFailure;
  late Failure<ForgetPasswordResponse> expectedResendFailure;

  setUpAll(() {
    mockVerificationUseCase = MockVerificationUseCase();
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
  });

  setUp(() {
    cubit = VerificationCubit(
      mockVerificationUseCase,
      mockForgetPasswordUseCase,
    );
    cubit.doIntent(InitVerificationIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });

  group("VerificationCubit test", () {
    blocTest<VerificationCubit, VerificationState>(
      'emits [Loading, Success, Timer Started] when resend code succeeds',
      build: () {
        final fakeResponse = ForgetPasswordResponse(message: "OTP resent successfully");
        expectedResendSuccess = Success<ForgetPasswordResponse>(fakeResponse);
        provideDummy<Result<ForgetPasswordResponse>>(expectedResendSuccess);

        when(mockForgetPasswordUseCase.call(any))
            .thenAnswer((_) async => expectedResendSuccess);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
          OnResendCodeClickIntent(
          request:const ForgetPasswordRequestEntity(email: 'test@email.com'),
        ),
      ),
      expect: () => [
        isA<VerificationState>()
            .having((s) => s.resendCodeStatus.isLoading, 'Loading', true),
        isA<VerificationState>()
            .having((s) => s.resendCodeStatus.isSuccess, 'Success', true),
        isA<VerificationState>()
            .having((s) => s.secondsRemaining, 'Timer Started', equals(30)),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits [Loading, Failure] when resend code fails',
      build: () {
        expectedResendFailure = Failure(
          responseException: const ResponseException(message: "Resend failed"),
        );
        provideDummy<Result<ForgetPasswordResponse>>(expectedResendFailure);

        when(mockForgetPasswordUseCase.call(any))
            .thenAnswer((_) async => expectedResendFailure);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
         OnResendCodeClickIntent(
          request:const ForgetPasswordRequestEntity(email: 'fail@email.com'),
        ),
      ),
      expect: () => [
        isA<VerificationState>()
            .having((s) => s.resendCodeStatus.isLoading, 'Loading', true),
        isA<VerificationState>()
            .having((s) => s.resendCodeStatus.isFailure, 'Failure', true)
            .having(
              (s) => s.resendCodeStatus.error?.message,
          'Error Message',
          equals("Resend failed"),
        ),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits [Loading, Success] when verification succeeds',
      build: () {
        final fakeResponse = VerificationResponse(status: "Verified");
        expectedVerifySuccess = Success<VerificationResponse>(fakeResponse);
        provideDummy<Result<VerificationResponse>>(expectedVerifySuccess);

        when(mockVerificationUseCase.call(request: anyNamed('request')))
            .thenAnswer((_) async => expectedVerifySuccess);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
          OnConfirmClickIntent(
          request: const VerificationRequestEntity(resetCode: '123456'),
        ),
      ),
      expect: () => [
        isA<VerificationState>()
            .having((s) => s.verifyCodeStatus.isLoading, 'Loading', true),
        isA<VerificationState>()
            .having((s) => s.verifyCodeStatus.isSuccess, 'Success', true),
      ],
      verify: (_) {
        verify(mockVerificationUseCase.call(request: anyNamed('request'))).called(1);
      },
    );

    blocTest<VerificationCubit, VerificationState>(
      'emits [Loading, Failure] when verification fails',
      build: () {
        expectedVerifyFailure = Failure(
          responseException: const ResponseException(message: "Invalid Code"),
        );
        provideDummy<Result<VerificationResponse>>(expectedVerifyFailure);

        when(mockVerificationUseCase.call(request: anyNamed('request')))
            .thenAnswer((_) async => expectedVerifyFailure);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
         OnConfirmClickIntent(
          request:const VerificationRequestEntity(resetCode: '000000'),
        ),
      ),
      expect: () => [
        isA<VerificationState>()
            .having((s) => s.verifyCodeStatus.isLoading, 'Loading', true),
        isA<VerificationState>()
            .having((s) => s.verifyCodeStatus.isFailure, 'Failure', true)
            .having(
              (s) => s.verifyCodeStatus.error?.message,
          'Error Message',
          equals("Invalid Code"),
        ),
      ],
      verify: (_) {
        verify(mockVerificationUseCase.call(request: anyNamed('request'))).called(1);
      },
    );
  });
}
