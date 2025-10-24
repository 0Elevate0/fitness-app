import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/data/data_source/reset_password/remote_data_sourse/remote_data_sourse.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:ResetPasswordRepository )
class ResetPasswordRepositoryImpl implements ResetPasswordRepository{
  final ResetPasswordRemoteDataSource _resetPasswordRemoteDataSource;
  const ResetPasswordRepositoryImpl(this._resetPasswordRemoteDataSource);
  @override
  Future<Result<ResetPasswordResponse>> resetPassword({required ResetPasswordRequestEntity request}) {
   return _resetPasswordRemoteDataSource.resetPassword(request: request);
  }
}