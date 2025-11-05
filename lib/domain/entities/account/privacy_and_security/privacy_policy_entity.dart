import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';

final class PrivacyPolicyEntity extends Equatable {
  final List<PrivacySectionEntity> sections;

  const PrivacyPolicyEntity({required this.sections});

  @override
  List<Object?> get props => [sections];
}
