import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/text_style_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/role_definition_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';

class SecurityRolesSectionModel {
  final String? section;
  final LocalizedTextModel? content;
  final LocalizedTextModel? title;
  final TextStyleModel? style;
  final RoleDefinitionModel? roleDefinition;

  const SecurityRolesSectionModel({
    this.section,
    this.content,
    this.title,
    this.style,
    this.roleDefinition,
  });

  static SecurityRolesSectionModel empty() => const SecurityRolesSectionModel();

  factory SecurityRolesSectionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty();

    // Determine section type
    final sectionType = json['section'] as String?;
    RoleDefinitionModel? roleDef;

    if (sectionType == 'role_definition') {
      roleDef = RoleDefinitionModel.fromJson(json);
    }

    return SecurityRolesSectionModel(
      section: sectionType,
      content: LocalizedTextModel.fromJson(json['content']),
      title: LocalizedTextModel.fromJson(json['title']),
      style: TextStyleModel.fromJson(json['style']),
      roleDefinition: roleDef,
    );
  }

  SecurityRolesSectionEntity toEntity() => SecurityRolesSectionEntity(
    section: section,
    content: content?.toEntity(),
    title: title?.toEntity(),
    style: style?.toEntity(),
    roleDefinition: roleDefinition?.toEntity(),
  );
}
