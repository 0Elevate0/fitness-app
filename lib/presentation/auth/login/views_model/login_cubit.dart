import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:fitness_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;

  @factoryMethod
  LoginCubit(this._loginWithEmailAndPasswordUseCase)
    : super(const LoginState());

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late GlobalKey<FormState> loginFormKey;

  Future<void> doIntent({required LoginIntent intent}) async {
    switch (intent) {
      case InitializeLoginFormIntent():
        _onInit();
        break;
      case LoginWithEmailAndPasswordIntent():
        await _login();
        break;
      case ToggleObscurePasswordIntent():
        _toggleObscure();
        break;
      case CheckFieldsValidationIntent():
        _checkFieldsValidation();
        break;
      case EnableValidationIntent():
        _enableFieldsValidation();
        break;
    }
  }

  void _onInit() async {
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _toggleObscure() {
    emit(
      state.copyWith(
        isObscure: !state.isObscure,
        loginStatus: const StateStatus.initial(),
      ),
    );
  }

  void _checkFieldsValidation() {
    if (state.isContinueClickedWhenDisabled) {
      if (loginFormKey.currentState!.validate()) {
        emit(state.copyWith(isValidToLogin: true));
      } else {
        emit(state.copyWith(isValidToLogin: false));
      }
    } else {
      if (Validations.emailValidation(email: emailController.text.trim()) ==
              null &&
          Validations.passwordValidation(
                password: passwordController.text.trim(),
              ) ==
              null) {
        emit(state.copyWith(isValidToLogin: true));
      } else {
        emit(state.copyWith(isValidToLogin: false));
      }
    }
  }

  Future<void> _login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(state.copyWith(loginStatus: const StateStatus.loading()));
      final loginResult = await _loginWithEmailAndPasswordUseCase.invoke(
        request: LoginRequestEntity(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (loginResult) {
        case Success<void>():
          emit(state.copyWith(loginStatus: const StateStatus.success(null)));
          break;
        case Failure<void>():
          emit(
            state.copyWith(
              loginStatus: StateStatus.failure(loginResult.responseException),
            ),
          );
          break;
      }
    }
  }

  void _enableFieldsValidation() {
    emit(state.copyWith(isContinueClickedWhenDisabled: true));
    _checkFieldsValidation();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
