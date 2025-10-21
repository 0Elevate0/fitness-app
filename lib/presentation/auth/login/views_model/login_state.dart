import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

final class LoginState extends Equatable {
  final StateStatus<void> loginStatus;
  final bool isObscure;
  final bool isValidToLogin;
  final bool isContinueClickedWhenDisabled;

  const LoginState({
    this.loginStatus = const StateStatus.initial(),
    this.isObscure = true,
    this.isValidToLogin = false,
    this.isContinueClickedWhenDisabled = false,
  });

  LoginState copyWith({
    StateStatus<void>? loginStatus,
    bool? isObscure,
    AutovalidateMode? autoValidateMode,
    bool? isValidToLogin,
    bool? isContinueClickedWhenDisabled,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      isObscure: isObscure ?? this.isObscure,
      isValidToLogin: isValidToLogin ?? this.isValidToLogin,
      isContinueClickedWhenDisabled:
          isContinueClickedWhenDisabled ?? this.isContinueClickedWhenDisabled,
    );
  }

  @override
  List<Object?> get props => [
    loginStatus,
    isObscure,
    isValidToLogin,
    isContinueClickedWhenDisabled,
  ];
}
