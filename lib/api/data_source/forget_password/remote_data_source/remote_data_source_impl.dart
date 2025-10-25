import 'package:fitness_app/api/client/api_client.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/requests/request_mapper.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/data/data_source/forget_password/remote_data_source/remote_data_source.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl implements ForgetPasswordRemoteDataSource{
  final ApiClient _apiClient;
  const ForgetPasswordRemoteDataSourceImpl(this._apiClient);
  @override
  Future<Result<ForgetPasswordResponse>> forgetPassword({required ForgetPasswordRequestEntity request}) async {
      return await executeApi(() async{
        final response = await  _apiClient.forgotPassword(request:
        RequestMapper.toForgetPasswordRequestModel(forgetPasswordRequestEntity: request)
        );
        return response;
      });
  }
}