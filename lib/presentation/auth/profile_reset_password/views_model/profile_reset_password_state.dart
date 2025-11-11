import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ProfileResetPasswordState extends Equatable {
  final StateStatus<void> profileResetPasswordState;
  final AutovalidateMode autoValidateMode;
  final bool currentPasswordIsObscure;
  final bool confirmPasswordIsObscure;
  final bool newPasswordIsObscure;

  const ProfileResetPasswordState({
    this.profileResetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
    this.currentPasswordIsObscure = true,
    this.confirmPasswordIsObscure = true,
    this.newPasswordIsObscure = true,
  });

  ProfileResetPasswordState copyWith({
    StateStatus<void>? profileResetPasswordState,
    AutovalidateMode? autoValidateMode,
    bool? currentPasswordIsObscure,
    bool? confirmPasswordIsObscure,
    bool? newPasswordIsObscure,
  }) {
    return ProfileResetPasswordState(
      profileResetPasswordState:
          profileResetPasswordState ?? this.profileResetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      currentPasswordIsObscure:
          currentPasswordIsObscure ?? this.currentPasswordIsObscure,
      confirmPasswordIsObscure:
          confirmPasswordIsObscure ?? this.confirmPasswordIsObscure,
      newPasswordIsObscure: newPasswordIsObscure ?? this.newPasswordIsObscure,
    );
  }

  @override
  List<Object?> get props => [
    profileResetPasswordState,
    autoValidateMode,
    currentPasswordIsObscure,
    confirmPasswordIsObscure,
    newPasswordIsObscure,
  ];
}
