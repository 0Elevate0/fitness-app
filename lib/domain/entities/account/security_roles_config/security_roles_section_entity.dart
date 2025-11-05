import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';

final class SecurityRolesSectionEntity extends Equatable {
  final String? section;
  final LocalizedTextEntity? content;
  final LocalizedTextEntity? title;
  final TextStyleEntity? style;
  final RoleDefinitionEntity? roleDefinition;

  const SecurityRolesSectionEntity({
    this.section,
    this.content,
    this.title,
    this.style,
    this.roleDefinition,
  });

  @override
  List<Object?> get props => [section, content, title, style, roleDefinition];
}
