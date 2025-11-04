import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';
import 'package:fitness_app/domain/use_cases/profile_reset_password/profile_reset_password_usecase.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileResetPasswordCubit extends Cubit<ProfileResetPasswordState> {
  final GetProfileResetPasswordUseCase _useCase;

  @factoryMethod
  ProfileResetPasswordCubit(this._useCase)
    : super(const ProfileResetPasswordState());
  late GlobalKey<FormState> formKey;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  void doIntent(ProfileResetPasswordIntent intent) {
    switch (intent) {
      case InitializeProfileResetPasswordFormIntent():
        return _onInit();
      case OnProfileResetPasswordIntent():
        return _profileResetPassword();
      case CurrentToggleObscurePasswordIntent():
        return _currentPasswordToggleObscure();
      case ConfirmToggleObscurePasswordIntent():
        return _confirmPasswordToggleObscure();
      case NewToggleObscurePasswordIntent():
        return _newPasswordToggleObscure();
    }
  }

  void _onInit() {
    formKey = GlobalKey<FormState>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _currentPasswordToggleObscure() {
    emit(
      state.copyWith(
        currentPasswordIsObscure: !state.currentPasswordIsObscure,
        profileResetPasswordState: const StateStatus.initial(),
      ),
    );
  }

  void _confirmPasswordToggleObscure() {
    emit(
      state.copyWith(
        confirmPasswordIsObscure: !state.confirmPasswordIsObscure,
        profileResetPasswordState: const StateStatus.initial(),
      ),
    );
  }

  void _newPasswordToggleObscure() {
    emit(
      state.copyWith(
        newPasswordIsObscure: !state.newPasswordIsObscure,
        profileResetPasswordState: const StateStatus.initial(),
      ),
    );
  }

  void _profileResetPassword() async {
    if (formKey.currentState!.validate()) {
      emit(
        state.copyWith(
          profileResetPasswordState: const StateStatus.loading(),
          autoValidateMode: AutovalidateMode.disabled,
        ),
      );
      final res = await _useCase.execute(
        ProfileResetPasswordRequestEntity(
          password: currentPasswordController.text,
          newPassword: confirmPasswordController.text,
        ),
      );
      switch (res) {
        case Success<ProfileResetPasswordResponse>():
          emit(
            state.copyWith(
              profileResetPasswordState: const StateStatus.success(null),
            ),
          );
        case Failure<ProfileResetPasswordResponse>():
          emit(
            state.copyWith(
              profileResetPasswordState: StateStatus.failure(
                res.responseException,
              ),
            ),
          );
      }
    } else {
      emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
