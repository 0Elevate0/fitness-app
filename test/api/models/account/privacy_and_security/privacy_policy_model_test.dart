import 'package:fitness_app/api/models/account/privacy_and_security/privacy_policy_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_section_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PrivacyPolicyModel → PrivacyPolicyEntity", () {
    test(
      "when call toEntity with null values it should return PrivacyPolicyEntity with empty sections list",
      () {
        // Arrange
        final PrivacyPolicyModel privacyPolicyModel = PrivacyPolicyModel(
          sections: null,
        );

        // Act
        final PrivacyPolicyEntity actualResult = privacyPolicyModel.toEntity();

        // Assert
        expect(actualResult.sections, isEmpty);
      },
    );

    test(
      "when call toEntity with non-null values it should return PrivacyPolicyEntity with correct values",
      () {
        // Arrange
        final mockSection = PrivacySectionModel(section: "Section 1");
        final PrivacyPolicyModel privacyPolicyModel = PrivacyPolicyModel(
          sections: [mockSection],
        );

        // Act
        final PrivacyPolicyEntity actualResult = privacyPolicyModel.toEntity();

        // Assert
        expect(actualResult.sections.length, equals(1));
        expect(actualResult.sections.first.section, equals("Section 1"));
      },
    );
  });

  group("PrivacyPolicyModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct PrivacyPolicyModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "privacy_policy": [
            {
              "section": "1",
              "title": {"en": "Privacy", "ar": "الخصوصية"},
              "content": {
                "en": ["Your data is secure"],
                "ar": ["بياناتك آمنة"],
              },
              "style": {
                "fontSize": 14,
                "fontWeight": "bold",
                "color": "#000000",
              },
              "sub_sections": [],
            },
          ],
        };

        // Act
        final PrivacyPolicyModel actualResult = PrivacyPolicyModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.sections, isNotNull);
        expect(actualResult.sections!.length, equals(1));
        expect(actualResult.sections!.first.section, equals("1"));
        expect(actualResult.sections!.first.title?.en, equals("Privacy"));
        expect(actualResult.sections!.first.title?.ar, equals("الخصوصية"));
      },
    );

    test(
      "when call fromJson with null privacy_policy it should return model with null sections",
      () {
        // Arrange
        final Map<String, dynamic> json = {"privacy_policy": null};

        // Act
        final PrivacyPolicyModel actualResult = PrivacyPolicyModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.sections, isNull);
      },
    );

    test(
      "when call fromJson with empty JSON it should return model with null sections",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final PrivacyPolicyModel actualResult = PrivacyPolicyModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.sections, isNull);
      },
    );
  });
}
