import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_align_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LocalizedTextAlignModel → LocalizedTextAlignEntity", () {
    test(
      "when call toEntity with null values it should return LocalizedTextAlignEntity with null values",
      () {
        // Arrange
        final LocalizedTextAlignModel model = LocalizedTextAlignModel(
          en: null,
          ar: null,
        );

        // Act
        final LocalizedTextAlignEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.en, equals(model.en));
        expect(actualResult.ar, equals(model.ar));
      },
    );

    test(
      "when call toEntity with non-null values it should return LocalizedTextAlignEntity with correct values",
      () {
        // Arrange
        final LocalizedTextAlignModel model = LocalizedTextAlignModel(
          en: "left",
          ar: "right",
        );

        // Act
        final LocalizedTextAlignEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.en, equals("left"));
        expect(actualResult.ar, equals("right"));
      },
    );

    test(
      "when call fromJson with valid JSON it should return correct LocalizedTextAlignModel object",
      () {
        // Arrange
        final Map<String, dynamic> json = {"en": "center", "ar": "center"};

        // Act
        final LocalizedTextAlignModel actualResult =
            LocalizedTextAlignModel.fromJson(json);

        // Assert
        expect(actualResult.en, equals("center"));
        expect(actualResult.ar, equals("center"));
      },
    );

    test(
      "when call fromJson with null JSON it should return empty LocalizedTextAlignModel",
      () {
        // Act
        final LocalizedTextAlignModel actualResult =
            LocalizedTextAlignModel.fromJson(null);

        // Assert
        expect(actualResult.en, isNull);
        expect(actualResult.ar, isNull);
      },
    );

    test(
      "when call fromJson with missing keys it should return LocalizedTextAlignModel with null fields",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final LocalizedTextAlignModel actualResult =
            LocalizedTextAlignModel.fromJson(json);

        // Assert
        expect(actualResult.en, isNull);
        expect(actualResult.ar, isNull);
      },
    );
  });
}
