import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_sub_section_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PrivacySubSectionModel → PrivacySubSectionEntity", () {
    test(
      "when call toEntity with null values it should return PrivacySubSectionEntity with null values",
      () {
        // Arrange
        final PrivacySubSectionModel model = PrivacySubSectionModel(
          type: null,
          title: null,
          content: null,
        );

        // Act
        final PrivacySubSectionEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.type, equals(model.type));
        expect(actualResult.title, equals(model.title?.toEntity()));
        expect(actualResult.content, equals(model.content?.toEntity()));
      },
    );

    test(
      "when call toEntity with non-null values it should return PrivacySubSectionEntity with correct values",
      () {
        // Arrange
        final titleModel = LocalizedTextModel(
          en: "Terms of Use",
          ar: "شروط الاستخدام",
        );
        final contentModel = LocalizedTextModel(
          en: "Details about usage...",
          ar: "تفاصيل حول الاستخدام...",
        );
        final PrivacySubSectionModel model = PrivacySubSectionModel(
          type: "section",
          title: titleModel,
          content: contentModel,
        );

        // Act
        final PrivacySubSectionEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.type, equals("section"));
        expect(actualResult.title, equals(titleModel.toEntity()));
        expect(actualResult.content, equals(contentModel.toEntity()));
      },
    );
  });

  group("PrivacySubSectionModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct PrivacySubSectionModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "type": "sub_section",
          "title": {"en": "Privacy Policy", "ar": "سياسة الخصوصية"},
          "content": {
            "en": ["We collect data", "We respect your privacy"],
            "ar": ["نحن نجمع البيانات", "نحترم خصوصيتك"],
          },
        };

        // Act
        final PrivacySubSectionModel actualResult =
            PrivacySubSectionModel.fromJson(json);

        // Assert
        expect(actualResult.type, equals("sub_section"));
        expect(actualResult.title, isA<LocalizedTextModel>());
        expect(actualResult.title?.en, equals("Privacy Policy"));
        expect(actualResult.title?.ar, equals("سياسة الخصوصية"));

        // LocalizedTextModel should join list values into newline-separated string
        expect(
          actualResult.content?.en,
          equals("We collect data\nWe respect your privacy"),
        );
        expect(
          actualResult.content?.ar,
          equals("نحن نجمع البيانات\nنحترم خصوصيتك"),
        );
      },
    );

    test(
      "when call fromJson with null nested fields it should handle gracefully",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "type": "info",
          "title": null,
          "content": null,
        };

        // Act
        final PrivacySubSectionModel actualResult =
            PrivacySubSectionModel.fromJson(json);

        // Assert
        expect(actualResult.type, equals("info"));
        expect(actualResult.title, isNull);
        expect(actualResult.content, isNull);
      },
    );

    test(
      "when call fromJson with empty JSON it should return model with null values",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final PrivacySubSectionModel actualResult =
            PrivacySubSectionModel.fromJson(json);

        // Assert
        expect(actualResult.type, isNull);
        expect(actualResult.title, isNull);
        expect(actualResult.content, isNull);
      },
    );
  });
}
