import 'package:fitness_app/api/models/account/help/title_model.dart';
import 'package:fitness_app/domain/entities/account/help/title_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TitleModel → TitleEntity", () {
    test(
      "when call toEntity with null values it should return TitleEntity with null values",
      () {
        // Arrange
        final TitleModel titleModel = TitleModel(en: null, ar: null);

        // Act
        final TitleEntity actualResult = titleModel.toEntity();

        // Assert
        expect(actualResult.en, equals(titleModel.en));
        expect(actualResult.ar, equals(titleModel.ar));
      },
    );

    test(
      "when call toEntity with non-null values it should return TitleEntity with correct values",
      () {
        // Arrange
        final TitleModel titleModel = TitleModel(
          en: "Help & Support",
          ar: "المساعدة والدعم",
        );

        // Act
        final TitleEntity actualResult = titleModel.toEntity();

        // Assert
        expect(actualResult.en, equals("Help & Support"));
        expect(actualResult.ar, equals("المساعدة والدعم"));
      },
    );

    test(
      "when call fromJson with valid JSON it should return correct TitleModel object",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "en": "Contact Us",
          "ar": "اتصل بنا",
        };

        // Act
        final TitleModel actualResult = TitleModel.fromJson(json);

        // Assert
        expect(actualResult.en, equals("Contact Us"));
        expect(actualResult.ar, equals("اتصل بنا"));
      },
    );

    test(
      "when call fromJson with null values it should return TitleModel with null properties",
      () {
        // Arrange
        final Map<String, dynamic> json = {"en": null, "ar": null};

        // Act
        final TitleModel actualResult = TitleModel.fromJson(json);

        // Assert
        expect(actualResult.en, isNull);
        expect(actualResult.ar, isNull);
      },
    );
  });
}
