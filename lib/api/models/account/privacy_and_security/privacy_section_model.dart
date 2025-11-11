import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_sub_section_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/text_style_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';

class PrivacySectionModel {
  final String? section;
  final LocalizedTextModel? title;
  final LocalizedTextModel? content;
  final TextStyleModel? style;
  final List<PrivacySubSectionModel>? subSections;

  PrivacySectionModel({
    this.section,
    this.title,
    this.content,
    this.style,
    this.subSections,
  });

  factory PrivacySectionModel.fromJson(Map<String, dynamic> json) {
    return PrivacySectionModel(
      section: json['section'] as String?,
      title: json['title'] != null
          ? LocalizedTextModel.fromJson(json['title'])
          : null,
      content: json['content'] != null
          ? LocalizedTextModel.fromJson(json['content'])
          : null,
      style: json['style'] != null
          ? TextStyleModel.fromJson(json['style'])
          : null,
      subSections: (json['sub_sections'] as List?)
          ?.map((e) => PrivacySubSectionModel.fromJson(e))
          .toList(),
    );
  }

  PrivacySectionEntity toEntity() {
    return PrivacySectionEntity(
      section: section,
      title: title?.toEntity(),
      content: content?.toEntity(),
      style: style?.toEntity(),
      subSections: subSections?.map((e) => e.toEntity()).toList(),
    );
  }
}
