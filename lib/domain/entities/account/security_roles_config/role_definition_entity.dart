import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';

final class RoleDefinitionEntity extends Equatable {
  final String? roleId;
  final LocalizedTextEntity? name;
  final LocalizedTextEntity? description;
  final Map<String, dynamic>? style;
  final List<PermissionEntity>? permissions;

  const RoleDefinitionEntity({
    this.roleId,
    this.name,
    this.description,
    this.style,
    this.permissions,
  });

  @override
  List<Object?> get props => [roleId, name, description, style, permissions];
}
