import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/profile_reset_password/profile_reset_password_usecase.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'profile_reset_password_cubit_test.mocks.dart';

@GenerateMocks([GetProfileResetPasswordUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetProfileResetPasswordUseCase getProfileResetPasswordUseCase;
  late ProfileResetPasswordCubit cubit;
  late Result<ProfileResetPasswordResponse> expectedSuccessResult;
  late Failure<ProfileResetPasswordResponse> expectedFailureResult;

  final expectedResponse = ProfileResetPasswordResponse(
    token: 'sample_token',
    message: 'Password Changed successfully',
  );
  setUpAll(() {
    getProfileResetPasswordUseCase = MockGetProfileResetPasswordUseCase();
  });
  setUp(() {
    cubit = ProfileResetPasswordCubit(getProfileResetPasswordUseCase);
    cubit.doIntent(InitializeProfileResetPasswordFormIntent());
    cubit.formKey = FakeGlobalKey(FakeFormState());
  });
  blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
    'should emit [loading, success] when ChangePassword is successful',
    build: () {
      expectedSuccessResult = Success<ProfileResetPasswordResponse>(
        expectedResponse,
      );
      provideDummy<Result<ProfileResetPasswordResponse>>(expectedSuccessResult);
      when(
        getProfileResetPasswordUseCase.execute(any),
      ).thenAnswer((_) async => expectedSuccessResult); // success
      return cubit;
    },
    act: (cubit) => cubit.doIntent(OnProfileResetPasswordIntent()),
    expect: () => [
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.loading(),
      ),
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.success(null),
      ),
    ],
    verify: (_) {
      verify(getProfileResetPasswordUseCase.execute(any)).called(1);
    },
  );
  blocTest(
    "emits [Loading, Failure] when OnProfileResetPasswordIntent is Called",
    build: () {
      expectedFailureResult = Failure(
        responseException: const ResponseException(
          message: "failed to change password",
        ),
      );
      provideDummy<Result<ProfileResetPasswordResponse>>(expectedFailureResult);
      when(
        getProfileResetPasswordUseCase.execute(any),
      ).thenAnswer((_) async => expectedFailureResult);
      return cubit;
    },
    act: (cubit) => cubit.doIntent(OnProfileResetPasswordIntent()),
    expect: () => [
      isA<ProfileResetPasswordState>().having(
        (state) => state.profileResetPasswordState.isLoading,
        "Is Loading State",
        equals(true),
      ),
      isA<ProfileResetPasswordState>()
          .having(
            (state) => state.profileResetPasswordState.isFailure,
            "Is Failure State",
            equals(true),
          )
          .having(
            (state) => state.profileResetPasswordState.error?.message,
            'responseException.message',
            expectedFailureResult.responseException.message,
          ),
    ],

    verify: (_) {
      verify(getProfileResetPasswordUseCase.execute(any)).called(1);
    },
  );

  blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
    'Change password visibility for CurrentPasswordTextField when ToggleObscurePasswordIntent',
    build: () => cubit,
    act: (cubit) => cubit.doIntent(CurrentToggleObscurePasswordIntent()),
    expect: () => const [
      ProfileResetPasswordState(currentPasswordIsObscure: false),
    ],
  );
  blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
    'Change password visibility for ConfirmPasswordTextField when ToggleObscurePasswordIntent',
    build: () => cubit,
    act: (cubit) => cubit.doIntent(ConfirmToggleObscurePasswordIntent()),
    expect: () => const [
      ProfileResetPasswordState(confirmPasswordIsObscure: false),
    ],
  );
  blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
    'Change password visibility when for NewPasswordTextField ToggleObscurePasswordIntent',
    build: () => cubit,
    act: (cubit) => cubit.doIntent(NewToggleObscurePasswordIntent()),
    expect: () => const [
      ProfileResetPasswordState(newPasswordIsObscure: false),
    ],
  );
}
