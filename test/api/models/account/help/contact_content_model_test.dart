import 'package:fitness_app/api/models/account/help/contact_content_model.dart';
import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/api/models/account/help/style_model.dart';
import 'package:fitness_app/domain/entities/account/help/contact_content_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("ContactContentModel → ContactContentEntity", () {
    test(
      "when call toEntity with null values it should return ContactContentEntity with null values",
      () {
        // Arrange
        final ContactContentModel model = ContactContentModel(
          id: null,
          method: null,
          details: null,
          value: null,
          style: null,
        );

        // Act
        final ContactContentEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.id, equals(model.id));
        expect(actualResult.method, equals(model.method?.toEntity()));
        expect(actualResult.details, equals(model.details?.toEntity()));
        expect(actualResult.value, equals(model.value));
        expect(actualResult.style, equals(model.style?.toEntity()));
      },
    );

    test(
      "when call toEntity with non-null values it should return ContactContentEntity with correct values",
      () {
        // Arrange
        final ContentModel method = ContentModel(
          en: "Email",
          ar: "البريد الإلكتروني",
        );

        final ContentModel details = ContentModel(
          en: "Contact us via email",
          ar: "تواصل معنا عبر البريد الإلكتروني",
        );

        final StyleModel style = StyleModel(fontSize: 16, color: "#333333");

        final ContactContentModel model = ContactContentModel(
          id: "1",
          method: method,
          details: details,
          value: "support@fitnessapp.com",
          style: style,
        );

        // Act
        final ContactContentEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.id, equals(model.id));
        expect(actualResult.method?.en, equals(method.en));
        expect(actualResult.details?.ar, equals(details.ar));
        expect(actualResult.value, equals(model.value));
        expect(actualResult.style?.color, equals(style.color));
      },
    );

    test(
      "when call fromJson with valid JSON it should return correct ContactContentModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "id": "2",
          "method": {"en": "Phone", "ar": "الهاتف"},
          "details": {
            "en": "Call us during working hours",
            "ar": "اتصل بنا خلال ساعات العمل",
          },
          "value": "+123456789",
          "style": {"fontSize": 14, "color": "#FF0000"},
        };

        // Act
        final ContactContentModel model = ContactContentModel.fromJson(json);

        // Assert
        expect(model.id, equals("2"));
        expect(model.method?.en, equals("Phone"));
        expect(model.details?.ar, equals("اتصل بنا خلال ساعات العمل"));
        expect(model.value, equals("+123456789"));
        expect(model.style?.color, equals("#FF0000"));
        expect(model.style?.fontSize, equals(14));
      },
    );
  });
}
