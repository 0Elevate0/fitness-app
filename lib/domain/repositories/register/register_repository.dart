import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';

abstract interface class RegisterRepository {
  Future<Result<void>> register({required RegisterRequestEntity request});
}
