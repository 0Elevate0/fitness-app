import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';

final class PrivacySubSectionEntity extends Equatable {
  final String? type;
  final LocalizedTextEntity? title;
  final LocalizedTextEntity? content;

  const PrivacySubSectionEntity({this.type, this.title, this.content});

  @override
  List<Object?> get props => [type, title, content];
}
