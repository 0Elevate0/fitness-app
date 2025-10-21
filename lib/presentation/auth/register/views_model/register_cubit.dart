import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());
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
        break;
      case RegistrationProcess.physical:
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

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
