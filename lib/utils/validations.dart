import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';

abstract final class Validations {
  static String? fieldValidation({required String? value}) {
    if ((value?.isEmpty ?? true) || value?.trim() == "") {
      return AppText.fieldValidation.tr();
    }
    return null;
  }

  static String? emailValidation({required String? email}) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9](?:[a-zA-Z0-9._%+-]{0,62}[a-zA-Z0-9])?@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$',
    );
    if (email?.trim() == "" || (email?.isEmpty ?? true) || email == null) {
      return AppText.emailValidation.tr();
    } else if (!emailRegex.hasMatch(email) ||
        email.contains("..") ||
        email.contains(".-") ||
        email.contains("-.")) {
      return AppText.emailValidation2.tr();
    }
    return null;
  }

  static String? passwordValidation({required String? password}) {
    if ((password?.isEmpty ?? true) ||
        password?.trim() == "" ||
        password == null) {
      return AppText.passwordValidation.tr();
    } else if (password.length < 8) {
      return AppText.passwordValidation2.tr();
    } else if (RegExp(r'\s').hasMatch(password)) {
      return AppText.passwordValidation3.tr();
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return AppText.passwordValidation4.tr();
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return AppText.passwordValidation6.tr();
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return AppText.passwordValidation7.tr();
    } else if (password.length > 20) {
      return AppText.passwordValidation5.tr();
    }
    return null;
  }

  static String? confirmPasswordValidation({
    required String? confirmPassword,
    required String? password,
  }) {
    if ((confirmPassword?.isEmpty ?? true) ||
        confirmPassword?.trim() == "" ||
        confirmPassword == null) {
      return AppText.confirmPasswordValidation.tr();
    } else if (confirmPassword != password) {
      return AppText.confirmPasswordValidation2.tr();
    } else if (RegExp(r'\s').hasMatch(confirmPassword)) {
      return AppText.passwordValidation3.tr();
    }
    return null;
  }
}
