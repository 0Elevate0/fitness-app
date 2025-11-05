import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/repositories/security_roles_config/security_roles_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecurityRolesConfigUseCase {
  final SecurityRolesConfigRepository _securityRolesConfigRepository;
  const SecurityRolesConfigUseCase(this._securityRolesConfigRepository);

  Future<Result<SecurityRolesConfigEntity>> invoke() async {
    return await _securityRolesConfigRepository.fetchSecurityRolesConfigData();
  }
}
