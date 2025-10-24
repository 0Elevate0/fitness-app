import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

final class LoginState extends Equatable {
  final StateStatus<void> loginStatus;
  final bool isObscure;
  final AutovalidateMode autoValidateMode;

  const LoginState({
    this.loginStatus = const StateStatus.initial(),
    this.isObscure = true,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  LoginState copyWith({
    StateStatus<void>? loginStatus,
    bool? isObscure,
    AutovalidateMode? autoValidateMode,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      isObscure: isObscure ?? this.isObscure,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }

  @override
  List<Object?> get props => [loginStatus, isObscure, autoValidateMode];
}
