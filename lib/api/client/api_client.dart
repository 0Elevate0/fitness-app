import 'package:dio/dio.dart';
import 'package:fitness_app/api/requests/forget_password_request/forget_password_request_model.dart';
import 'package:fitness_app/api/requests/reset_password_request/reset_password_request_model.dart';
import 'package:fitness_app/api/requests/verification_request/verification_request_model.dart';
import 'package:fitness_app/api/responses/forgot_password_response/forgot_password_response.dart';
import 'package:fitness_app/api/responses/reset_password_response/reset_password_response.dart';
import 'package:fitness_app/api/responses/verification_response/verification_response.dart';
import 'package:fitness_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.forgotPassword)
  Future<ForgetPasswordResponse> forgotPassword({
    @Body() required ForgetPasswordRequestModel request,
  });

  @POST(Endpoints.verifyResetCode)
  Future<VerificationResponse> verificationCode({
    @Body() required VerificationRequestModel request
});
  @PUT(Endpoints.resetPassword)
  Future<ResetPasswordResponse>resetPassword({
    @Body() required ResetPasswordRequestModel request});
}
