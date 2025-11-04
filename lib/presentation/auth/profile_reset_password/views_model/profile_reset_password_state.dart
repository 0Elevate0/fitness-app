import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ProfileResetPasswordState extends Equatable {
  final StateStatus<void> profileResetPasswordState;
  final AutovalidateMode autoValidateMode;
  final bool isObscure;

  const ProfileResetPasswordState({
    this.profileResetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isObscure = true,
  });

  ProfileResetPasswordState copyWith({
    StateStatus<void>? profileResetPasswordState,
    AutovalidateMode? autoValidateMode,
    bool? isObscure,
  }) {
    return ProfileResetPasswordState(
      profileResetPasswordState:
          profileResetPasswordState ?? this.profileResetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object?> get props => [
    profileResetPasswordState,
    autoValidateMode,
    isObscure,
  ];
}
