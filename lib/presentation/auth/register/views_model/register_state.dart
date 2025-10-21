import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum RegistrationProcess { form, gender, old, weight, height, goal, physical }

enum Gender { male, female }

final class RegisterState extends Equatable {
  final AutovalidateMode autoValidateMode;
  final bool isObscure;
  final RegistrationProcess currentRegistrationProcess;
  final Gender? selectedGender;
  final String selectedYearsOld;
  final String selectedWeight;
  final String selectedHeight;

  const RegisterState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isObscure = true,
    this.currentRegistrationProcess = RegistrationProcess.form,
    this.selectedGender,
    this.selectedYearsOld = "25",
    this.selectedWeight = "90",
    this.selectedHeight = "167",
  });
  RegisterState copyWith({
    AutovalidateMode? autoValidateMode,
    bool? isObscure,
    RegistrationProcess? currentRegistrationProcess,
    Gender? selectedGender,
    String? selectedYearsOld,
    String? selectedWeight,
    String? selectedHeight,
  }) {
    return RegisterState(
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isObscure: isObscure ?? this.isObscure,
      currentRegistrationProcess:
          currentRegistrationProcess ?? this.currentRegistrationProcess,
      selectedGender: selectedGender ?? this.selectedGender,
      selectedYearsOld: selectedYearsOld ?? this.selectedYearsOld,
      selectedWeight: selectedWeight ?? this.selectedWeight,
      selectedHeight: selectedHeight ?? this.selectedHeight,
    );
  }

  @override
  List<Object?> get props => [
    autoValidateMode,
    isObscure,
    currentRegistrationProcess,
    selectedGender,
    selectedYearsOld,
    selectedWeight,
    selectedHeight,
  ];
}
