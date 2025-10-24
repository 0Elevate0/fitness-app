import 'package:dio/dio.dart';
import 'package:fitness_app/api/requests/register_request/register_request_model.dart';
import 'package:fitness_app/core/constants/endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: Endpoints.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(Endpoints.signup)
  Future<void> register({@Body() required RegisterRequestModel request});
}
