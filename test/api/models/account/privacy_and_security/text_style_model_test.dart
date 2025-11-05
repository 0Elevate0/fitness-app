import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_align_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/text_style_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TextStyleModel → TextStyleEntity", () {
    test(
      "when call toEntity with null values it should return TextStyleEntity with null values",
      () {
        // Arrange
        final TextStyleModel model = TextStyleModel(
          fontSize: null,
          fontWeight: null,
          color: null,
          contentFontSize: null,
          contentFontWeight: null,
          contentColor: null,
          textAlign: null,
          backgroundColor: null,
          highlightColor: null,
        );

        // Act
        final TextStyleEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.fontSize, equals(model.fontSize));
        expect(actualResult.fontWeight, equals(model.fontWeight));
        expect(actualResult.color, equals(model.color));
        expect(actualResult.contentFontSize, equals(model.contentFontSize));
        expect(actualResult.contentFontWeight, equals(model.contentFontWeight));
        expect(actualResult.contentColor, equals(model.contentColor));
        expect(actualResult.textAlign, equals(model.textAlign?.toEntity()));
        expect(actualResult.backgroundColor, equals(model.backgroundColor));
        expect(actualResult.highlightColor, equals(model.highlightColor));
      },
    );

    test(
      "when call toEntity with non-null values it should return TextStyleEntity with correct values",
      () {
        // Arrange
        final textAlignModel = LocalizedTextAlignModel(en: "left", ar: "right");
        final TextStyleModel model = TextStyleModel(
          fontSize: 16.0,
          fontWeight: "bold",
          color: "#000000",
          contentFontSize: 14.0,
          contentFontWeight: "normal",
          contentColor: "#333333",
          textAlign: textAlignModel,
          backgroundColor: "#FFFFFF",
          highlightColor: "#FF0000",
        );

        // Act
        final TextStyleEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.fontSize, equals(16.0));
        expect(actualResult.fontWeight, equals("bold"));
        expect(actualResult.color, equals("#000000"));
        expect(actualResult.contentFontSize, equals(14.0));
        expect(actualResult.contentFontWeight, equals("normal"));
        expect(actualResult.contentColor, equals("#333333"));
        expect(
          actualResult.textAlign,
          equals(textAlignModel.toEntity()),
        ); // nested check
        expect(actualResult.backgroundColor, equals("#FFFFFF"));
        expect(actualResult.highlightColor, equals("#FF0000"));
      },
    );
  });

  group("TextStyleModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct TextStyleModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "fontSize": 18,
          "fontWeight": "bold",
          "color": "#222222",
          "contentFontSize": 15,
          "contentFontWeight": "medium",
          "contentColor": "#555555",
          "textAlign": {"en": "center", "ar": "right"},
          "backgroundColor": "#F0F0F0",
          "highlightColor": "#00FF00",
        };

        // Act
        final TextStyleModel actualResult = TextStyleModel.fromJson(json);

        // Assert
        expect(actualResult.fontSize, equals(18.0));
        expect(actualResult.fontWeight, equals("bold"));
        expect(actualResult.color, equals("#222222"));
        expect(actualResult.contentFontSize, equals(15.0));
        expect(actualResult.contentFontWeight, equals("medium"));
        expect(actualResult.contentColor, equals("#555555"));
        expect(actualResult.textAlign, isA<LocalizedTextAlignModel>());
        expect(actualResult.textAlign?.en, equals("center"));
        expect(actualResult.textAlign?.ar, equals("right"));
        expect(actualResult.backgroundColor, equals("#F0F0F0"));
        expect(actualResult.highlightColor, equals("#00FF00"));
      },
    );

    test(
      "when call fromJson with nested 'title' key it should parse inner map correctly",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "title": {
            "fontSize": 20,
            "fontWeight": "normal",
            "color": "#000000",
            "backgroundColor": "#FFFFFF",
          },
        };

        // Act
        final TextStyleModel actualResult = TextStyleModel.fromJson(json);

        // Assert
        expect(actualResult.fontSize, equals(20.0));
        expect(actualResult.fontWeight, equals("normal"));
        expect(actualResult.color, equals("#000000"));
        expect(actualResult.backgroundColor, equals("#FFFFFF"));
      },
    );

    test(
      "when call fromJson with empty JSON it should return model with null fields",
      () {
        // Arrange
        final Map<String, dynamic> json = {};

        // Act
        final TextStyleModel actualResult = TextStyleModel.fromJson(json);

        // Assert
        expect(actualResult.fontSize, isNull);
        expect(actualResult.fontWeight, isNull);
        expect(actualResult.color, isNull);
        expect(actualResult.textAlign, isNull);
      },
    );
  });
}
