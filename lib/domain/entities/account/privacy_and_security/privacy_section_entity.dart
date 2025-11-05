import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';

final class PrivacySectionEntity extends Equatable {
  final String? section;
  final LocalizedTextEntity? title;
  final LocalizedTextEntity? content;
  final TextStyleEntity? style;
  final List<PrivacySubSectionEntity>? subSections;

  const PrivacySectionEntity({
    this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });

  @override
  List<Object?> get props => [section, title, content, style, subSections];
}
