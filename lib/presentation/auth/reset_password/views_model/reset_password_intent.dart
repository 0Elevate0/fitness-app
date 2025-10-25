import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';

sealed class ResetPasswordIntent {
 }

class InitResetPasswordFormIntent
    extends ResetPasswordIntent {}


class OnDoneClick extends ResetPasswordIntent {
  ResetPasswordRequestEntity request;

  OnDoneClick({required this.request});
}
class TogglePasswordVisibility extends ResetPasswordIntent {}
class ToggleConfirmPasswordVisibility extends ResetPasswordIntent {}
