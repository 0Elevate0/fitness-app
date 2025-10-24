import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordCubit(this._resetPasswordUseCase)
    : super(const ResetPasswordState());
  late GlobalKey<FormState> formKey;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;


  void doIntent(ResetPasswordIntent intent) {
    switch (intent) {
      case InitResetPasswordFormIntent():
        _onInit();
      case OnDoneClick():
        _handelDoneClick(intent);
      case TogglePasswordVisibility():
        _togglePasswordVisibility();
      case ToggleConfirmPasswordVisibility():
        _toggleConfirmPasswordVisibility();

    }
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _toggleConfirmPasswordVisibility() {
    emit(state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }
  void _onInit() {
    formKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    emit(
      state.copyWith(
        resetPasswordState: const StateStatus.initial(),
        autoValidateMode: AutovalidateMode.disabled,
      ),
    );
  }

  void _handelDoneClick(OnDoneClick intent) async {
    if (formKey.currentState!.validate()) {

      emit(state.copyWith(resetPasswordState: const StateStatus.loading()));
      final res = await _resetPasswordUseCase.call(request: intent.request);
      switch (res) {
        case Success<ResetPasswordResponse>():
          emit(
            state.copyWith(resetPasswordState: const StateStatus.success(null)),
          );
        case Failure<ResetPasswordResponse>():
          emit(
            state.copyWith(
              resetPasswordState: StateStatus.failure(res.responseException),
            ),
          );
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  void _enableAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
