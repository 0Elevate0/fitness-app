import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LocalizedTextModel → LocalizedTextEntity", () {
    test(
      "when call toEntity with null values it should return LocalizedTextEntity with null values",
      () {
        // Arrange
        final LocalizedTextModel model = LocalizedTextModel(en: null, ar: null);

        // Act
        final LocalizedTextEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.en, equals(model.en));
        expect(actualResult.ar, equals(model.ar));
      },
    );

    test(
      "when call toEntity with non-null String values it should return LocalizedTextEntity with correct values",
      () {
        // Arrange
        final LocalizedTextModel model = LocalizedTextModel(
          en: "Privacy Policy",
          ar: "سياسة الخصوصية",
        );

        // Act
        final LocalizedTextEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.en, equals("Privacy Policy"));
        expect(actualResult.ar, equals("سياسة الخصوصية"));
      },
    );

    test(
      "when call toEntity with List values it should join items using newline",
      () {
        // Arrange
        final LocalizedTextModel model = LocalizedTextModel(
          en: ["Line 1", "Line 2"],
          ar: ["السطر ١", "السطر ٢"],
        );

        // Act
        final LocalizedTextEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.en, equals("Line 1\nLine 2"));
        expect(actualResult.ar, equals("السطر ١\nالسطر ٢"));
      },
    );

    test(
      "when call fromJson with valid JSON and String values it should return correct LocalizedTextModel object",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "en": "Terms of Service",
          "ar": "شروط الخدمة",
        };

        // Act
        final LocalizedTextModel actualResult = LocalizedTextModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.en, equals("Terms of Service"));
        expect(actualResult.ar, equals("شروط الخدمة"));
      },
    );

    test(
      "when call fromJson with valid JSON and List values it should join lists correctly",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "en": ["Line A", "Line B"],
          "ar": ["سطر أ", "سطر ب"],
        };

        // Act
        final LocalizedTextModel actualResult = LocalizedTextModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.en, equals("Line A\nLine B"));
        expect(actualResult.ar, equals("سطر أ\nسطر ب"));
      },
    );

    test(
      "when call fromJson with null JSON it should return empty LocalizedTextModel",
      () {
        // Act
        final LocalizedTextModel actualResult = LocalizedTextModel.fromJson(
          null,
        );

        // Assert
        expect(actualResult.en, isNull);
        expect(actualResult.ar, isNull);
      },
    );

    test(
      "when call fromJson with missing keys it should return LocalizedTextModel with null fields",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final LocalizedTextModel actualResult = LocalizedTextModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.en, isNull);
        expect(actualResult.ar, isNull);
      },
    );
  });
}
