import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/data/data_source/forget_password/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/forget_password/forget_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSource _forgetPasswordRemoteDataSource;

  const ForgetPasswordRepositoryImpl(this._forgetPasswordRemoteDataSource);

  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword({
    required ForgetPasswordRequestEntity request,
  }) {
    return _forgetPasswordRemoteDataSource.forgetPassword(request: request);
  }
}
