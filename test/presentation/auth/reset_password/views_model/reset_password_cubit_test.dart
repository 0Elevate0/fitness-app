import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_cubit_test.mocks.dart';
import '../../../../fake_form_state.dart';

@GenerateMocks([ResetPasswordUseCase])
void main() {

  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late ResetPasswordCubit cubit;
  late Result<ResetPasswordResponse> expectedSuccessResult;
  late Failure<ResetPasswordResponse> expectedFailureResult;

  setUpAll(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
  });

  setUp(() {
    cubit = ResetPasswordCubit(mockResetPasswordUseCase);
    cubit.doIntent(InitResetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });

  group("ResetPasswordCubit test", () {
    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [autoValidate, Loading, Success] when OnDoneClick succeeds',
      build: () {
        final fakeResponse = ResetPasswordResponse(
          message: "Password reset successfully",
          token: "fake_token",
        );
        expectedSuccessResult = Success<ResetPasswordResponse>(fakeResponse);
        provideDummy<Result<ResetPasswordResponse>>(expectedSuccessResult);

        when(mockResetPasswordUseCase.call(request: anyNamed('request')))
            .thenAnswer((_) async => expectedSuccessResult);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        OnDoneClick(
          request: const ResetPasswordRequestEntity(
            email: 'test@email.com',
            newPassword: '123456',
          ),
        ),
      ),
      expect: () => const [
        ResetPasswordState(
          resetPasswordState: StateStatus.initial(),
          autoValidateMode: AutovalidateMode.always,
        ),
        ResetPasswordState(
          resetPasswordState: StateStatus.loading(),
          autoValidateMode: AutovalidateMode.always,
        ),
        ResetPasswordState(
          resetPasswordState: StateStatus.success(null),
          autoValidateMode: AutovalidateMode.always,
        ),
      ],
      verify: (_) {
        verify(mockResetPasswordUseCase.call(request: anyNamed('request')))
            .called(1);
      },
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [autoValidate, Loading, Failure] when OnDoneClick fails',
      build: () {
        expectedFailureResult = Failure(
          responseException:
          const ResponseException(message: "Failed to reset password"),
        );
        provideDummy<Result<ResetPasswordResponse>>(expectedFailureResult);

        when(mockResetPasswordUseCase.call(request: anyNamed('request')))
            .thenAnswer((_) async => expectedFailureResult);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(
        OnDoneClick(
          request: const ResetPasswordRequestEntity(
            email: 'fail@email.com',
            newPassword: '123456',
          ),
        ),
      ),
      expect: () => [
        isA<ResetPasswordState>().having(
              (s) => s.autoValidateMode,
          'AutoValidateMode',
          equals(AutovalidateMode.always),
        ),
        isA<ResetPasswordState>().having(
              (s) => s.resetPasswordState.isLoading,
          'Is Loading State',
          equals(true),
        ),
        isA<ResetPasswordState>()
            .having(
              (s) => s.resetPasswordState.isFailure,
          'Is Failure State',
          equals(true),
        )
            .having(
              (s) => s.resetPasswordState.error?.message,
          'responseException.message',
          expectedFailureResult.responseException.message,
        ),
      ],
      verify: (_) {
        verify(mockResetPasswordUseCase.call(request: anyNamed('request')))
            .called(1);
      },
    );
  });
}
