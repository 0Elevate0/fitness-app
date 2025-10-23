import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:fitness_app/domain/use_cases/register/register_use_case.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(const RegisterState());
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late GlobalKey<FormState> registerFormKey;

  Future<void> doIntent({required RegisterIntent intent}) async {
    switch (intent) {
      case RegisterInitializationIntent():
        _onInit();
        break;
      case ToggleObscurePasswordIntent():
        _toggleObscurePassword();
        break;
      case MoveToRegistrationNextStepIntent():
        await _moveToNextRegistrationProcess();
        break;
      case MoveToRegistrationPreviousStepIntent():
        _moveToPreviousRegistrationProcess();
        break;
      case ChangeSelectedGenderIntent():
        _changeSelectedGender(newSelectedGender: intent.newSelectedGender);
        break;
      case ChangeSelectedYearsIntent():
        _changeSelectedYearsOld(years: intent.newSelectedYears);
        break;
      case ChangeSelectedWeightIntent():
        _changeSelectedWeight(kg: intent.newSelectedWeight);
        break;
      case ChangeSelectedHeightIntent():
        _changeSelectedHeight(cm: intent.newSelectedHeight);
        break;
      case SelectGoalIntent():
        _selectGoal(goal: intent.goal);
        break;
      case SelectActivityIntent():
        _selectActivity(activity: intent.activity);
        break;
    }
  }

  void _onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    registerFormKey = GlobalKey<FormState>();
  }

  void _toggleObscurePassword() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  Future<void> _moveToNextRegistrationProcess() async {
    switch (state.currentRegistrationProcess) {
      case RegistrationProcess.form:
        {
          if (registerFormKey.currentState!.validate()) {
            emit(
              state.copyWith(
                currentRegistrationProcess: RegistrationProcess.gender,
                autoValidateMode: AutovalidateMode.disabled,
              ),
            );
          } else {
            emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
          }
        }
        break;
      case RegistrationProcess.gender:
        {
          if (state.selectedGender != null) {
            emit(
              state.copyWith(
                currentRegistrationProcess: RegistrationProcess.old,
              ),
            );
          }
        }
        break;
      case RegistrationProcess.old:
        emit(
          state.copyWith(
            currentRegistrationProcess: RegistrationProcess.weight,
          ),
        );
        break;
      case RegistrationProcess.weight:
        emit(
          state.copyWith(
            currentRegistrationProcess: RegistrationProcess.height,
          ),
        );
        break;
      case RegistrationProcess.height:
        emit(
          state.copyWith(currentRegistrationProcess: RegistrationProcess.goal),
        );
        break;
      case RegistrationProcess.goal:
        emit(
          state.copyWith(
            currentRegistrationProcess: RegistrationProcess.physical,
          ),
        );
        break;
      case RegistrationProcess.physical:
        await _registerUser();
        break;
    }
  }

  void _moveToPreviousRegistrationProcess() {
    emit(
      state.copyWith(
        currentRegistrationProcess: RegistrationProcess.values.elementAt(
          state.currentRegistrationProcess.index - 1,
        ),
      ),
    );
  }

  void _changeSelectedGender({required String newSelectedGender}) {
    final gender = newSelectedGender.toLowerCase().trim() == Gender.male.name
        ? Gender.male
        : Gender.female;
    emit(state.copyWith(selectedGender: gender));
  }

  void _changeSelectedYearsOld({required int years}) {
    emit(state.copyWith(selectedYearsOld: years.toString()));
  }

  void _changeSelectedWeight({required int kg}) {
    emit(state.copyWith(selectedWeight: kg.toString()));
  }

  void _changeSelectedHeight({required int cm}) {
    emit(state.copyWith(selectedHeight: cm.toString()));
  }

  void _selectGoal({required String goal}) {
    emit(state.copyWith(selectedGoal: goal));
  }

  void _selectActivity({required String activity}) {
    emit(state.copyWith(selectedActivity: activity));
  }

  Future<void> _registerUser() async {
    emit(state.copyWith(registerStatus: const StateStatus.loading()));
    final result = await _registerUseCase.invoke(
      request: RegisterRequestEntity(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rePassword: passwordController.text.trim(),
        gender: state.selectedGender?.name ?? "",
        height: int.parse(state.selectedHeight),
        weight: int.parse(state.selectedWeight),
        age: int.parse(state.selectedYearsOld),
        goal: state.selectedGoal ?? "",
        activityLevel: FitnessMethodHelper.getCurrentActivityLevel(
          activityLevelTitle: state.selectedActivity ?? "",
        ),
      ),
    );
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(state.copyWith(registerStatus: const StateStatus.success(null)));
        break;
      case Failure<void>():
        {
          emit(
            state.copyWith(
              registerStatus: StateStatus.failure(result.responseException),
            ),
          );
          emit(state.copyWith(registerStatus: const StateStatus.initial()));
        }
        break;
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
