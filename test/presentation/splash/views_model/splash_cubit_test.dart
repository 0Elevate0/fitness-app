import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:fitness_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_intent.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([GetUserDataUseCase, SecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockSecureStorage mockSecureStorage;
  late SplashCubit cubit;
  late Result<void> expectedSuccessResult;
  late Failure<void> expectedFailureResult;

  setUpAll(() {
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockSecureStorage = MockSecureStorage();
    expectedFailureResult = Failure(
      responseException: const ResponseException(message: "failed to login"),
    );
    expectedSuccessResult = Success<void>(null);
    provideDummy<Result<void>>(expectedSuccessResult);
    provideDummy<Result<void>>(expectedFailureResult);
  });
  setUp(() {
    cubit = SplashCubit(mockGetUserDataUseCase, mockSecureStorage);
  });

  group("Splash cubit test", () {
    blocTest<SplashCubit, SplashState>(
      'emits [Loading, Success] when GetUserDataIntent succeeds',
      build: () {
        when(
          mockGetUserDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: const GetUserDataIntent()),
      expect: () => [
        isA<SplashState>().having(
          (state) => state.userDataStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<SplashState>().having(
          (state) => state.userDataStatus.isSuccess,
          "Is in Success state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(mockGetUserDataUseCase.invoke()).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when GetUserDataIntent is Called",
      build: () {
        when(
          mockGetUserDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: const GetUserDataIntent()),
      expect: () => [
        isA<SplashState>().having(
          (state) => state.userDataStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<SplashState>()
            .having(
              (state) => state.userDataStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.userDataStatus.error?.message,
              'responseException.message',
              equals(expectedFailureResult.responseException.message),
            ),
        isA<SplashState>().having(
          (state) => state.userDataStatus.isInitial,
          "Is back to initial state",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(mockGetUserDataUseCase.invoke()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [LoginNavigationState] when NavigateToLoginViewIntent is Called',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: const NavigateToLoginViewIntent()),
      expect: () => [
        isA<SplashState>()
            .having(
              (state) => state.isNavigationToLogin,
              "Is NavigationToLogin state",
              equals(true),
            )
            .having(
              (_) => FitnessMethodHelper.userData,
              'when NavigateToLoginViewIntent is called userData should be reset to null',
              null,
            )
            .having(
              (_) => FitnessMethodHelper.currentUserToken,
              'when NavigateToLoginViewIntent is called currentUserToken should be reset to null',
              null,
            ),
      ],
    );
  });
}
