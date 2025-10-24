import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';

sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}

class InitForgetPasswordFormIntent extends ForgetPasswordIntent {
  const InitForgetPasswordFormIntent();
}

class OnSendOtpClick extends ForgetPasswordIntent {
  final ForgetPasswordRequestEntity request;

  const OnSendOtpClick({required this.request});
}
