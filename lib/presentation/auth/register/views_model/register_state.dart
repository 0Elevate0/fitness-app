import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum RegistrationProcess { form, gender, old, weight, height, goal, physical }

enum Gender { male, female }

final class RegisterState extends Equatable {
  final AutovalidateMode autoValidateMode;
  final bool isObscure;
  final RegistrationProcess currentRegistrationProcess;
  final Gender? selectedGender;

  const RegisterState({
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isObscure = true,
    this.currentRegistrationProcess = RegistrationProcess.form,
    this.selectedGender,
  });
  RegisterState copyWith({
    AutovalidateMode? autoValidateMode,
    bool? isObscure,
    RegistrationProcess? currentRegistrationProcess,
    Gender? selectedGender,
  }) {
    return RegisterState(
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isObscure: isObscure ?? this.isObscure,
      currentRegistrationProcess:
          currentRegistrationProcess ?? this.currentRegistrationProcess,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  @override
  List<Object?> get props => [
    autoValidateMode,
    isObscure,
    currentRegistrationProcess,
    selectedGender,
  ];
}
