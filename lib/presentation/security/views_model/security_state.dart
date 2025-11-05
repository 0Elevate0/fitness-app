import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';

final class SecurityState extends Equatable {
  final StateStatus<SecurityRolesConfigEntity> securityStatus;

  const SecurityState({this.securityStatus = const StateStatus.initial()});

  SecurityState copyWith({
    StateStatus<SecurityRolesConfigEntity>? securityStatus,
  }) {
    return SecurityState(securityStatus: securityStatus ?? this.securityStatus);
  }

  @override
  List<Object?> get props => [securityStatus];
}
