import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:fitness_app/domain/entities/profile_reset_password/profile_reset_password_entity.dart';
import 'package:fitness_app/domain/repositories/profile_reset_password/profile_reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileResetPasswordRepository)
class ProfileResetPasswordRepositoryImpl
    implements ProfileResetPasswordRepository {
  final ProfileResetPasswordDataSource _dataSource;

  const ProfileResetPasswordRepositoryImpl(this._dataSource);

  @override
  Future<Result<void>> profileResetPassword(
    ProfileResetPasswordRequestEntity request,
  ) {
    return _dataSource.profileResetPassword(request: request);
  }
}
