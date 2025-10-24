import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordCubit(this._forgetPasswordUseCase)
    : super(const ForgetPasswordState());
  late GlobalKey<FormState> formKey;
  late final TextEditingController emailController;

  Future<void> doIntent(ForgetPasswordIntent intent) async {
    switch (intent) {
      case InitForgetPasswordFormIntent():
        _handleInit();
      case OnSendOtpClick():
        _handleSendOtp(intent);
    }
  }

  void _handleInit() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();

    emit(
      state.copyWith(
        status: const StateStatus.initial(),
        autoValidateMode: AutovalidateMode.disabled,
      ),
    );
  }



  Future<void> _handleSendOtp(OnSendOtpClick intent) async {
    if (formKey.currentState!.validate()) {

      emit(state.copyWith(status: const StateStatus.loading()));
    final res = await _forgetPasswordUseCase.call(intent.request);
    switch (res) {
      case Success<ForgetPasswordResponse>():
        emit(state.copyWith(status: const StateStatus.success(null)));
      case Failure<ForgetPasswordResponse>():
        emit(
          state.copyWith(status: StateStatus.failure(res.responseException)),
        );
    }
    } emit(state.copyWith(
      autoValidateMode: AutovalidateMode.always,
    ));
   }

}
