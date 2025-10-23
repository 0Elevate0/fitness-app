import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

enum RegistrationProcess { form, gender, old, weight, height, goal, physical }

enum Gender { male, female }

enum ActivityLevels { level1, level2, level3, level4, level5 }

final class RegisterState extends Equatable {
  final StateStatus<void> registerStatus;
  final AutovalidateMode autoValidateMode;
  final bool isObscure;
  final RegistrationProcess currentRegistrationProcess;
  final Gender? selectedGender;
  final String selectedYearsOld;
  final String selectedWeight;
  final String selectedHeight;
  final String? selectedGoal;
  final String? selectedActivity;

  const RegisterState({
    this.registerStatus = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isObscure = true,
    this.currentRegistrationProcess = RegistrationProcess.form,
    this.selectedGender,
    this.selectedYearsOld = "25",
    this.selectedWeight = "90",
    this.selectedHeight = "167",
    this.selectedGoal,
    this.selectedActivity,
  });
  RegisterState copyWith({
    StateStatus<void>? registerStatus,
    AutovalidateMode? autoValidateMode,
    bool? isObscure,
    RegistrationProcess? currentRegistrationProcess,
    Gender? selectedGender,
    String? selectedYearsOld,
    String? selectedWeight,
    String? selectedHeight,
    String? selectedGoal,
    String? selectedActivity,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isObscure: isObscure ?? this.isObscure,
      currentRegistrationProcess:
          currentRegistrationProcess ?? this.currentRegistrationProcess,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedYearsOld: selectedYearsOld ?? this.selectedYearsOld,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      selectedHeight: selectedHeight ?? this.selectedHeight,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedActivity: selectedActivity ?? this.selectedActivity,
    );
  }

  @override
  List<Object?> get props => [
    registerStatus,
    autoValidateMode,
    isObscure,
    currentRegistrationProcess,
    selectedGender,
    selectedYearsOld,
    selectedWeight,
    selectedHeight,
    selectedGoal,
    selectedActivity,
  ];
}
