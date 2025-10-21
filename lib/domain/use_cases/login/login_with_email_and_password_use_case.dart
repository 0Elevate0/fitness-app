import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:fitness_app/domain/repositories/login/login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginWithEmailAndPasswordUseCase {
  final LoginRepository _loginRepository;

  const LoginWithEmailAndPasswordUseCase(this._loginRepository);

  Future<Result<void>> invoke({required LoginRequestEntity request}) async {
    return await _loginRepository.login(request: request);
  }
}
