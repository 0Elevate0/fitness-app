import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';

final class PrivacyPolicyState extends Equatable {
  final StateStatus<PrivacyPolicyEntity> privacyPolicyStatus;

  const PrivacyPolicyState({
    this.privacyPolicyStatus = const StateStatus.initial(),
  });

  PrivacyPolicyState copyWith({
    StateStatus<PrivacyPolicyEntity>? privacyPolicyStatus,
  }) {
    return PrivacyPolicyState(
      privacyPolicyStatus: privacyPolicyStatus ?? this.privacyPolicyStatus,
    );
  }

  @override
  List<Object?> get props => [privacyPolicyStatus];
}
