import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ResetPasswordState extends Equatable {
  final StateStatus<void> resetPasswordState;
  final AutovalidateMode autoValidateMode;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  const ResetPasswordState({
    this.resetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  ResetPasswordState copyWith({
    StateStatus<void>? resetPasswordState,
    AutovalidateMode? autoValidateMode,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return ResetPasswordState(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props =>
      [resetPasswordState, autoValidateMode, isPasswordVisible, isConfirmPasswordVisible];
}