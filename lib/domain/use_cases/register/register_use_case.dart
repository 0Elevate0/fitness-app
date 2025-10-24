import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:fitness_app/domain/repositories/register/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepository _registerRepository;
  const RegisterUseCase(this._registerRepository);

  Future<Result<void>> invoke({required RegisterRequestEntity request}) async {
    return await _registerRepository.register(request: request);
  }
}
