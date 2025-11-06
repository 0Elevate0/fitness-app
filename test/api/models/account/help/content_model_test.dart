import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ContentModel → ContentEntity", () {
    test(
      "when calling toEntity with null values, it should return ContentEntity with null values",
      () {
        // Arrange
        final ContentModel contentModel = ContentModel(en: null, ar: null);

        // Act
        final ContentEntity actualResult = contentModel.toEntity();

        // Assert
        expect(actualResult.en, equals(contentModel.en));
        expect(actualResult.ar, equals(contentModel.ar));
      },
    );

    test(
      "when calling toEntity with non-null values, it should return ContentEntity with correct values",
      () {
        // Arrange
        final ContentModel contentModel = ContentModel(
          en: "Hello",
          ar: "مرحبا",
        );

        // Act
        final ContentEntity actualResult = contentModel.toEntity();

        // Assert
        expect(actualResult.en, equals(contentModel.en));
        expect(actualResult.ar, equals(contentModel.ar));
      },
    );
  });

  group("ContentModel.fromJson", () {
    test(
      "when calling fromJson with valid JSON, it should correctly parse the data",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "en": "Contact Us",
          "ar": "اتصل بنا",
        };

        // Act
        final ContentModel model = ContentModel.fromJson(json);

        // Assert
        expect(model.en, equals("Contact Us"));
        expect(model.ar, equals("اتصل بنا"));
      },
    );

    test(
      "when calling fromJson with null values, it should set fields to null",
      () {
        // Arrange
        final Map<String, dynamic> json = {"en": null, "ar": null};

        // Act
        final ContentModel model = ContentModel.fromJson(json);

        // Assert
        expect(model.en, isNull);
        expect(model.ar, isNull);
      },
    );
  });
}
