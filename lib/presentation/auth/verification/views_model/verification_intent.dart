import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/entities/requests/verification_request/verification_request_entity.dart';

sealed class VerificationIntent {
  const VerificationIntent();
}

class InitVerificationIntent extends VerificationIntent {}

class OnConfirmClickIntent extends VerificationIntent {
  VerificationRequestEntity request;

  OnConfirmClickIntent({required this.request});
}

class OnResendCodeClickIntent extends VerificationIntent {
  ForgetPasswordRequestEntity request;

  OnResendCodeClickIntent({required this.request});
}
class OnStartTimer extends VerificationIntent {}