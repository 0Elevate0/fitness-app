import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/profile_reset_password/profile_reset_password_response.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';
import 'package:fitness_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileResetPasswordUseCase {
  final ProfileResetPasswordRepository _repository;

  const GetProfileResetPasswordUseCase(this._repository);

  Future<Result<ProfileResetPasswordResponse>> execute(
    ProfileResetPasswordRequestEntity request,
  ) {
    return _repository.profileResetPassword(request);
  }
}
