import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/permission_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';

class RoleDefinitionModel {
  final String? roleId;
  final LocalizedTextModel? name;
  final LocalizedTextModel? description;
  final Map<String, dynamic>? style;
  final List<PermissionModel>? permissions;

  const RoleDefinitionModel({
    this.roleId,
    this.name,
    this.description,
    this.style,
    this.permissions,
  });

  static RoleDefinitionModel empty() => const RoleDefinitionModel();

  factory RoleDefinitionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty();
    return RoleDefinitionModel(
      roleId: json['role_id'] as String?,
      name: LocalizedTextModel.fromJson(json['name']),
      description: LocalizedTextModel.fromJson(json['description']),
      style: json['style'] as Map<String, dynamic>?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => PermissionModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  RoleDefinitionEntity toEntity() => RoleDefinitionEntity(
    roleId: roleId,
    name: name?.toEntity(),
    description: description?.toEntity(),
    style: style,
    permissions: permissions?.map((e) => e.toEntity()).toList(),
  );
}
