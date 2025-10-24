import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract interface class LoginRepository {
  Future<Result<void>> login({required LoginRequestEntity request});
}
