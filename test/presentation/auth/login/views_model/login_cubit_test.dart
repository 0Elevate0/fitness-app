import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:fitness_app/fake_form_state.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginWithEmailAndPasswordUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginWithEmailAndPasswordUseCase
  mockLoginWithEmailAndPasswordUseCase;
  late LoginCubit cubit;
  late Result<void> expectedSuccessResult;
  late Failure<void> expectedFailureResult;

  setUpAll(() {
    mockLoginWithEmailAndPasswordUseCase =
        MockLoginWithEmailAndPasswordUseCase();
  });
  setUp(() {
    cubit = LoginCubit(mockLoginWithEmailAndPasswordUseCase);
    cubit.doIntent(intent: InitializeLoginFormIntent());
    cubit.loginFormKey = FakeGlobalKey(FakeFormState());
  });

  group("Login cubit test", () {
    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] when LoginWithEmailAndPasswordIntent succeeds',
      build: () {
        expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => const [
        LoginState(loginStatus: StateStatus.loading()),
        LoginState(loginStatus: StateStatus.success(null)),
      ],
      verify: (_) {
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when LoginWithEmailAndPasswordIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to login",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<LoginState>()
            .having(
              (state) => state.loginStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.loginStatus.error?.message,
              'responseException.message',
              expectedFailureResult.responseException.message,
            ),
      ],

      verify: (_) {
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'Change password visibility when ToggleObscurePasswordIntent',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: ToggleObscurePasswordIntent()),
      expect: () => const [LoginState(isObscure: false)],
    );
  });
}
