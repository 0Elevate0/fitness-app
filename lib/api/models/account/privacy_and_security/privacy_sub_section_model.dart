import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';

class PrivacySubSectionModel {
  final String? type;
  final LocalizedTextModel? title;
  final LocalizedTextModel? content;

  PrivacySubSectionModel({this.type, this.title, this.content});

  factory PrivacySubSectionModel.fromJson(Map<String, dynamic> json) {
    return PrivacySubSectionModel(
      type: json['type'] as String?,
      title: json['title'] != null
          ? LocalizedTextModel.fromJson(json['title'])
          : null,
      content: json['content'] != null
          ? LocalizedTextModel.fromJson(json['content'])
          : null,
    );
  }

  PrivacySubSectionEntity toEntity() {
    return PrivacySubSectionEntity(
      type: type,
      title: title?.toEntity(),
      content: content?.toEntity(),
    );
  }
}
