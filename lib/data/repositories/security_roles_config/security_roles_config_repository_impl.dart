import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/security_roles_config/local_data_source/security_roles_config_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/repositories/security_roles_config/security_roles_config_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SecurityRolesConfigRepository)
final class SecurityRolesConfigRepositoryImpl
    implements SecurityRolesConfigRepository {
  final SecurityRolesConfigLocalDataSource _securityRolesConfigLocalDataSource;
  const SecurityRolesConfigRepositoryImpl(
    this._securityRolesConfigLocalDataSource,
  );

  @override
  Future<Result<SecurityRolesConfigEntity>>
  fetchSecurityRolesConfigData() async {
    return await _securityRolesConfigLocalDataSource
        .fetchSecurityRolesConfigData();
  }
}
