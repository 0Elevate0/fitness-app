import 'package:fitness_app/api/models/account/help/style_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_align_model.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("StyleModel → StyleEntity", () {
    test(
      "when call toEntity with null values it should return StyleEntity with null values",
      () {
        // Arrange
        final StyleModel styleModel = StyleModel(
          fontSize: null,
          fontWeight: null,
          color: null,
          backgroundColor: null,
          textAlign: null,
          nestedStyles: null,
        );

        // Act
        final StyleEntity actualResult = styleModel.toEntity();

        // Assert
        expect(actualResult.fontSize, equals(styleModel.fontSize));
        expect(actualResult.fontWeight, equals(styleModel.fontWeight));
        expect(actualResult.color, equals(styleModel.color));
        expect(
          actualResult.backgroundColor,
          equals(styleModel.backgroundColor),
        );
        expect(
          actualResult.textAlign,
          equals(styleModel.textAlign?.toEntity()),
        );
        expect(actualResult.nestedStyles, equals(styleModel.nestedStyles));
      },
    );

    test(
      "when call toEntity with non-null values it should return StyleEntity with correct values",
      () {
        // Arrange
        final textAlignModel = LocalizedTextAlignModel(en: "left", ar: "right");

        final nestedStyle = StyleModel(fontSize: 14.0, color: "#333333");

        final StyleModel styleModel = StyleModel(
          fontSize: 16.0,
          fontWeight: "bold",
          color: "#FFFFFF",
          backgroundColor: "#000000",
          textAlign: textAlignModel,
          nestedStyles: {"header": nestedStyle},
        );

        // Act
        final StyleEntity actualResult = styleModel.toEntity();

        // Assert
        expect(actualResult.fontSize, equals(16.0));
        expect(actualResult.fontWeight, equals("bold"));
        expect(actualResult.color, equals("#FFFFFF"));
        expect(actualResult.backgroundColor, equals("#000000"));
        expect(actualResult.textAlign?.en, equals("left"));
        expect(actualResult.textAlign?.ar, equals("right"));
        expect(actualResult.nestedStyles?.containsKey("header"), isTrue);
        expect(actualResult.nestedStyles?["header"]?.color, equals("#333333"));
      },
    );

    test(
      "when call fromJson with valid JSON it should return correct StyleModel object",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "fontSize": 18,
          "fontWeight": "medium",
          "color": "#FF0000",
          "backgroundColor": "#FFFFFF",
          "textAlign": {"en": "center", "ar": "center"},
          "nested": {"fontSize": 14, "color": "#333333"},
        };

        // Act
        final StyleModel actualResult = StyleModel.fromJson(json);

        // Assert
        expect(actualResult.fontSize, equals(18.0));
        expect(actualResult.fontWeight, equals("medium"));
        expect(actualResult.color, equals("#FF0000"));
        expect(actualResult.backgroundColor, equals("#FFFFFF"));
        expect(actualResult.textAlign?.en, equals("center"));
        expect(actualResult.textAlign?.ar, equals("center"));
        expect(actualResult.nestedStyles?.containsKey("nested"), isTrue);
        expect(actualResult.nestedStyles?["nested"]?.color, equals("#333333"));
      },
    );
  });
}
