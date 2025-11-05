import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';

final class SecurityRolesConfigEntity extends Equatable {
  final List<SecurityRolesSectionEntity>? sections;

  const SecurityRolesConfigEntity({this.sections});

  @override
  List<Object?> get props => [sections];
}
