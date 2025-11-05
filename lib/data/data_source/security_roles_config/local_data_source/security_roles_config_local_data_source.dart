import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';

abstract interface class SecurityRolesConfigLocalDataSource {
  Future<Result<SecurityRolesConfigEntity>> fetchSecurityRolesConfigData();
}
