import 'package:fitness_app/api/models/account/privacy_and_security/privacy_section_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';

class PrivacyPolicyModel {
  final List<PrivacySectionModel>? sections;

  PrivacyPolicyModel({this.sections});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      sections: (json['privacy_policy'] as List?)
          ?.map((e) => PrivacySectionModel.fromJson(e))
          .toList(),
    );
  }

  PrivacyPolicyEntity toEntity() {
    return PrivacyPolicyEntity(
      sections: sections?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
