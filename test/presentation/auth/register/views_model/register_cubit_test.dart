import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/use_cases/register/register_use_case.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRegisterUseCase mockRegisterUseCase;
  late Result<void> expectedRegisterSuccessResult;
  late Failure<void> expectedRegisterFailureResult;
  late RegisterCubit cubit;

  setUpAll(() {
    mockRegisterUseCase = MockRegisterUseCase();
  });

  setUp(() {
    cubit = RegisterCubit(mockRegisterUseCase);
    cubit.doIntent(intent: const RegisterInitializationIntent());
    cubit.registerFormKey = FakeGlobalKey(FakeFormState());
  });

  group("RegisterCubit test", () {
    blocTest(
      "emits [Loading, Success] when register is Called",
      build: () {
        expectedRegisterSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedRegisterSuccessResult);
        when(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedRegisterSuccessResult);
        cubit.emit(
          cubit.state.copyWith(
            currentRegistrationProcess: RegistrationProcess.physical,
          ),
        );
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const MoveToRegistrationNextStepIntent(),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<RegisterState>().having(
          (state) => state.registerStatus.isSuccess,
          "Is Success State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when logout is Called",
      build: () {
        expectedRegisterFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "Failed to register",
          ),
        );
        provideDummy<Result<void>>(expectedRegisterFailureResult);
        when(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedRegisterFailureResult);
        cubit.emit(
          cubit.state.copyWith(
            currentRegistrationProcess: RegistrationProcess.physical,
          ),
        );
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: const MoveToRegistrationNextStepIntent(),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<RegisterState>()
            .having(
              (state) => state.registerStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.registerStatus.error?.message,
              "Is having the Failure Message",
              equals(expectedRegisterFailureResult.responseException.message),
            ),
        isA<RegisterState>().having(
          (state) => state.registerStatus.isInitial,
          "Is Back to Initial State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest(
      "on ToggleObscurePasswordIntent emits isObscure with false  ",
      build: () => cubit,
      act: (cubit) async =>
          await cubit.doIntent(intent: const ToggleObscurePasswordIntent()),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.isObscure,
          "isObscure == false",
          equals(false),
        ),
      ],
    );

    blocTest(
      "on ChangeSelectedGenderIntent emits selectedGender with a non nullable value ",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeSelectedGenderIntent(
          newSelectedGender: AppText.male,
        ),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedGender,
          "selectedGender == male",
          equals(Gender.male),
        ),
      ],
    );

    blocTest(
      "on ChangeSelectedYearsIntent emits selectedYearsOld with the value selected",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeSelectedYearsIntent(newSelectedYears: 28),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedYearsOld,
          "selectedYearsOld == 28",
          equals("28"),
        ),
      ],
    );

    blocTest(
      "on ChangeSelectedWeightIntent emits selectedWeight with the value selected",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeSelectedWeightIntent(newSelectedWeight: 85),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedWeight,
          "selectedWeight == 85",
          equals("85"),
        ),
      ],
    );

    blocTest(
      "on ChangeSelectedHeightIntent emits selectedHeight with the value selected",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: const ChangeSelectedHeightIntent(newSelectedHeight: 186),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedHeight,
          "selectedHeight == 186",
          equals("186"),
        ),
      ],
    );

    blocTest(
      "on SelectGoalIntent emits selectedGoal with the value selected",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: SelectGoalIntent(goal: FitnessMethodHelper.goals[0]),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedGoal,
          "selectedGoal == the goal selected",
          equals(FitnessMethodHelper.goals[0]),
        ),
      ],
    );

    blocTest(
      "on SelectActivityIntent emits selectedActivity with the value selected",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: SelectActivityIntent(
          activity: FitnessMethodHelper.activityLevels[0],
        ),
      ),
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.selectedActivity,
          "activity == the selected activity",
          equals(FitnessMethodHelper.activityLevels[0]),
        ),
      ],
    );
  });
}
