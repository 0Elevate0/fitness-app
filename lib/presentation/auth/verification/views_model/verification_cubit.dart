import 'dart:async';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';
import 'package:fitness_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:fitness_app/domain/use_cases/verification/verification_use_case.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_intent.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final VerificationUseCase _verificationUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  VerificationCubit(this._verificationUseCase, this._forgetPasswordUseCase)
      : super(const VerificationState());
  Timer? _timer;
  late GlobalKey<FormState> formKey;
  late final TextEditingController verificationController;

  void doIntent(VerificationIntent intent) {
    switch (intent) {
      case InitVerificationIntent():
        return _onInit();
      case OnConfirmClickIntent():
        return _confirmClick(intent.request);

      case OnResendCodeClickIntent():
        return _resendCode(intent.request);
      case OnStartTimer():
        return _startTimer();
    }
  }

  void _resendCode(ForgetPasswordRequestEntity request) async {
    emit(state.copyWith(verifyCodeStatus: const StateStatus.loading()));
    final res = await _forgetPasswordUseCase.call(request);
    switch (res) {
      case Success<ForgetPasswordResponse>():
        emit(state.copyWith(resendCodeStatus: const StateStatus.success(null)));
        _startTimer();
      case Failure<ForgetPasswordResponse>():
        emit(
          state.copyWith(
            resendCodeStatus: StateStatus.failure(res.responseException),
          ),
        );
    }
  }

  void _confirmClick(VerificationRequestEntity request) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(verifyCodeStatus: const StateStatus.loading()));
      final res = await _verificationUseCase.call(request: request);
      switch (res) {
        case Success<VerificationResponse>():
          emit(
            state.copyWith(
              verifyCodeStatus: const StateStatus.success(null),
              isError: false,
            ),
          );

        case Failure<VerificationResponse>():
          emit(
            state.copyWith(
              verifyCodeStatus: StateStatus.failure(res.responseException),
              isError: true,
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

  void _onInit() {
    formKey = GlobalKey<FormState>();
    verificationController = TextEditingController();
    emit(state.copyWith(autoValidateMode: AutovalidateMode.disabled));
  }

  void _startTimer() {
    _timer?.cancel();
    int seconds = 30;
    emit(state.copyWith(secondsRemaining: seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(state.copyWith(secondsRemaining: seconds));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    verificationController.dispose();
    await super.close();
  }
}