import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/use_cases/logout/logout_use_case.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_intent.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLogoutUseCase mockLogoutUseCase;
  late Result<void> expectedLogoutSuccessResult;
  late Failure<void> expectedLogoutFailureResult;
  late ProfileCubit cubit;

  setUpAll(() {
    mockLogoutUseCase = MockLogoutUseCase();
  });

  setUp(() {
    cubit = ProfileCubit(mockLogoutUseCase);
  });

  group("Profile Cubit test", () {
    blocTest<ProfileCubit, ProfileState>(
      "emits [Loading, Success] when logout is Called",
      build: () {
        expectedLogoutSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedLogoutSuccessResult);
        when(
          mockLogoutUseCase.invoke(),
        ).thenAnswer((_) async => expectedLogoutSuccessResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(intent: LogoutIntent()),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.logoutStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<ProfileState>()
            .having(
              (state) => state.logoutStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (_) => FitnessMethodHelper.currentUserToken,
              "Current user token should be null",
              equals(null),
            )
            .having(
              (_) => FitnessMethodHelper.userData,
              "Current user data should be null",
              equals(null),
            ),
      ],
      verify: (_) {
        verify(mockLogoutUseCase.invoke()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      "emits [Loading, Failure] when logout is Called",
      build: () {
        expectedLogoutFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "Failed to logout",
          ),
        );
        provideDummy<Result<void>>(expectedLogoutFailureResult);
        when(
          mockLogoutUseCase.invoke(),
        ).thenAnswer((_) async => expectedLogoutFailureResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(intent: LogoutIntent()),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.logoutStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<ProfileState>()
            .having(
              (state) => state.logoutStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.logoutStatus.error?.message,
              "Is having the Failure Message",
              equals(expectedLogoutFailureResult.responseException.message),
            ),
        isA<ProfileState>().having(
          (state) => state.logoutStatus.isInitial,
          "Is back to Initial State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(mockLogoutUseCase.invoke()).called(1);
      },
    );
  });
}
