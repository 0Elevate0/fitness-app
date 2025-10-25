import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class VerificationState extends Equatable {
  final StateStatus<void> verifyCodeStatus;
  final StateStatus<void> resendCodeStatus;
  final int secondsRemaining;
  final bool isError;
  final AutovalidateMode autoValidateMode;

  const VerificationState({
    this.secondsRemaining = 0,
    this.isError = false,
    this.verifyCodeStatus = const StateStatus.initial(),
    this.resendCodeStatus = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  VerificationState copyWith({
    StateStatus<void>? verifyCodeStatus,
    int? secondsRemaining,
    bool? isError,
    StateStatus<void>? resendCodeStatus,
    AutovalidateMode? autoValidateMode,
  }) {
    return VerificationState(
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isError: isError ?? this.isError,
      resendCodeStatus: resendCodeStatus ?? this.resendCodeStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [
    verifyCodeStatus,
    secondsRemaining,
    isError,
    resendCodeStatus,
    autoValidateMode,
  ];
}