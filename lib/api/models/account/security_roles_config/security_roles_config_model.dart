import 'package:fitness_app/api/models/account/security_roles_config/security_roles_section_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';

class SecurityRolesConfigModel {
  final List<SecurityRolesSectionModel>? sections;

  const SecurityRolesConfigModel({this.sections});

  factory SecurityRolesConfigModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SecurityRolesConfigModel();
    return SecurityRolesConfigModel(
      sections: (json['security_roles_config'] as List<dynamic>?)
          ?.map(
            (e) =>
                SecurityRolesSectionModel.fromJson(e as Map<String, dynamic>?),
          )
          .toList(),
    );
  }

  SecurityRolesConfigEntity toEntity() => SecurityRolesConfigEntity(
    sections: sections?.map((e) => e.toEntity()).toList(),
  );
}
