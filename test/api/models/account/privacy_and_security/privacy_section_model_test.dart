import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_section_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_sub_section_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/text_style_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PrivacySectionModel → PrivacySectionEntity", () {
    test(
      "when call toEntity with null values it should return PrivacySectionEntity with null values",
      () {
        // Arrange
        final PrivacySectionModel model = PrivacySectionModel(
          section: null,
          title: null,
          content: null,
          style: null,
          subSections: null,
        );

        // Act
        final PrivacySectionEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.section, equals(model.section));
        expect(actualResult.title, equals(model.title?.toEntity()));
        expect(actualResult.content, equals(model.content?.toEntity()));
        expect(actualResult.style, equals(model.style?.toEntity()));
        expect(
          actualResult.subSections,
          equals(model.subSections?.map((e) => e.toEntity()).toList()),
        );
      },
    );

    test(
      "when call toEntity with non-null values it should return PrivacySectionEntity with correct values",
      () {
        // Arrange
        final titleModel = LocalizedTextModel(en: "Privacy", ar: "الخصوصية");
        final contentModel = LocalizedTextModel(
          en: "We protect your data",
          ar: "نحن نحمي بياناتك",
        );
        final styleModel = TextStyleModel(
          fontSize: 16,
          color: "#000000",
          fontWeight: "bold",
        );
        final subSectionModel = PrivacySubSectionModel(
          type: "sub",
          title: LocalizedTextModel(en: "Data Usage", ar: "استخدام البيانات"),
          content: LocalizedTextModel(
            en: "We use data securely",
            ar: "نستخدم البيانات بأمان",
          ),
        );

        final PrivacySectionModel model = PrivacySectionModel(
          section: "A",
          title: titleModel,
          content: contentModel,
          style: styleModel,
          subSections: [subSectionModel],
        );

        // Act
        final PrivacySectionEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.section, equals("A"));
        expect(actualResult.title, equals(titleModel.toEntity()));
        expect(actualResult.content, equals(contentModel.toEntity()));
        expect(actualResult.style, equals(styleModel.toEntity()));
        expect(actualResult.subSections?.length, equals(1));
        expect(
          actualResult.subSections?.first,
          equals(subSectionModel.toEntity()),
        );
      },
    );
  });

  group("PrivacySectionModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct PrivacySectionModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "section": "1",
          "title": {"en": "Privacy Policy", "ar": "سياسة الخصوصية"},
          "content": {
            "en": ["Your data is secure", "We respect privacy"],
            "ar": ["بياناتك آمنة", "نحترم الخصوصية"],
          },
          "style": {"fontSize": 14, "fontWeight": "normal", "color": "#333333"},
          "sub_sections": [
            {
              "type": "sub",
              "title": {"en": "Cookies", "ar": "الكوكيز"},
              "content": {"en": "We use cookies", "ar": "نستخدم الكوكيز"},
            },
          ],
        };

        // Act
        final PrivacySectionModel actualResult = PrivacySectionModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.section, equals("1"));
        expect(actualResult.title?.en, equals("Privacy Policy"));
        expect(actualResult.title?.ar, equals("سياسة الخصوصية"));
        expect(
          actualResult.content?.en,
          equals("Your data is secure\nWe respect privacy"),
        );
        expect(
          actualResult.content?.ar,
          equals("بياناتك آمنة\nنحترم الخصوصية"),
        );
        expect(actualResult.style?.fontSize, equals(14));
        expect(actualResult.style?.color, equals("#333333"));
        expect(actualResult.subSections?.length, equals(1));
        expect(actualResult.subSections?.first.type, equals("sub"));
        expect(actualResult.subSections?.first.title?.en, equals("Cookies"));
      },
    );

    test(
      "when call fromJson with null nested objects it should handle gracefully",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "section": "2",
          "title": null,
          "content": null,
          "style": null,
          "sub_sections": null,
        };

        // Act
        final PrivacySectionModel actualResult = PrivacySectionModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.section, equals("2"));
        expect(actualResult.title, isNull);
        expect(actualResult.content, isNull);
        expect(actualResult.style, isNull);
        expect(actualResult.subSections, isNull);
      },
    );

    test(
      "when call fromJson with empty JSON it should return model with null values",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final PrivacySectionModel actualResult = PrivacySectionModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.section, isNull);
        expect(actualResult.title, isNull);
        expect(actualResult.content, isNull);
        expect(actualResult.style, isNull);
        expect(actualResult.subSections, isNull);
      },
    );
  });
}
