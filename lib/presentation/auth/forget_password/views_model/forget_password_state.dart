import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class ForgetPasswordState extends Equatable {
  final StateStatus<void> forgetPasswordState;
  final AutovalidateMode autoValidateMode;

  const ForgetPasswordState({
    this.forgetPasswordState = const StateStatus.initial(),
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  ForgetPasswordState copyWith({
    StateStatus<void>? forgetPasswordState,
    AutovalidateMode? autoValidateMode,
  }) {
    return ForgetPasswordState(
      forgetPasswordState: forgetPasswordState  ?? this.forgetPasswordState,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
   List<Object?> get props => [forgetPasswordState,autoValidateMode
  ];
}
