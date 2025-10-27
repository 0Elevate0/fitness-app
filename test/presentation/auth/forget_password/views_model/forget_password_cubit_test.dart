import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';
import '../../../../fake_form_state.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {

  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late ForgetPasswordCubit cubit;
  late Result<ForgetPasswordResponse> expectedSuccessResult;
  late Failure<ForgetPasswordResponse> expectedFailureResult;

  setUpAll(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
  });

  setUp(() {
    cubit = ForgetPasswordCubit(mockForgetPasswordUseCase);
    cubit.doIntent(const InitForgetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });

  group("ForgetPasswordCubit test", () {
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [autoValidate, Loading, Success] when OnSendOtpClick succeeds',
      build: () {
        final fakeResponse = ForgetPasswordResponse(
          message: "OTP sent successfully",
          info: "Info",
        );
        expectedSuccessResult = Success<ForgetPasswordResponse>(fakeResponse);
        provideDummy<Result<ForgetPasswordResponse>>(expectedSuccessResult);

        when(mockForgetPasswordUseCase.call(any))
            .thenAnswer((_) async => expectedSuccessResult);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(const OnSendOtpClick(
        request: ForgetPasswordRequestEntity(email: 'test@email.com'),
      )),
      expect: () => const [
         ForgetPasswordState(
          forgetPasswordState: StateStatus.initial(),
          autoValidateMode: AutovalidateMode.always,
        ),
         ForgetPasswordState(
          forgetPasswordState: StateStatus.loading(),
          autoValidateMode: AutovalidateMode.always,
        ),
         ForgetPasswordState(
          forgetPasswordState: StateStatus.success(null),
          autoValidateMode: AutovalidateMode.always,
        ),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [autoValidate, Loading, Failure] when OnSendOtpClick fails',
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "Failed to send OTP",
          ),
        );
        provideDummy<Result<ForgetPasswordResponse>>(expectedFailureResult);

        when(mockForgetPasswordUseCase.call(any))
            .thenAnswer((_) async => expectedFailureResult);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(const OnSendOtpClick(
        request: ForgetPasswordRequestEntity(email: 'fail@email.com'),
      )),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.autoValidateMode,
          'AutoValidateMode',
          equals(AutovalidateMode.always),
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.forgetPasswordState.isLoading,
          'Is Loading State',
          equals(true),
        ),
        isA<ForgetPasswordState>()
            .having(
              (s) => s.forgetPasswordState.isFailure,
          'Is Failure State',
          equals(true),
        )
            .having(
              (s) => s.forgetPasswordState.error?.message,
          'responseException.message',
          expectedFailureResult.responseException.message,
        ),
      ],
      verify: (_) {
        verify(mockForgetPasswordUseCase.call(any)).called(1);
      },
    );
  });
}
