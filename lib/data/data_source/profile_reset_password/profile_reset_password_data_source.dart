import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';

abstract interface class ProfileResetPasswordDataSource {
  Future<Result<void>> profileResetPassword({
    required ProfileResetPasswordRequestEntity request,
  });
}
