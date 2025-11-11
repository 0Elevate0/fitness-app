import 'package:fitness_app/api/models/account/help/help_model.dart';
import 'package:fitness_app/api/models/account/help/help_section_model.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("HelpModel → HelpEntity", () {
    test(
      "when call toEntity with null values it should return HelpEntity with null values",
      () {
        // Arrange
        final HelpModel helpModel = HelpModel(helpScreenContent: null);

        // Act
        final HelpEntity actualResult = helpModel.toEntity();

        // Assert
        expect(
          actualResult.helpScreenContent,
          equals(helpModel.helpScreenContent),
        );
      },
    );

    test(
      "when call toEntity with non-null values it should return HelpEntity with correct values",
      () {
        // Arrange
        final HelpSectionModel section1 = HelpSectionModel(section: "FAQ");

        final HelpSectionModel section2 = HelpSectionModel(
          section: "Contact Us",
        );

        final HelpModel helpModel = HelpModel(
          helpScreenContent: [section1, section2],
        );

        // Act
        final HelpEntity actualResult = helpModel.toEntity();

        // Assert
        expect(actualResult.helpScreenContent?.length, equals(2));
        expect(
          actualResult.helpScreenContent?.first.title,
          equals(section1.title),
        );
        expect(
          actualResult.helpScreenContent?.last.content,
          equals(section2.content),
        );
      },
    );
  });

  group("HelpModel.fromJson", () {
    test(
      "when call fromJson with null list it should set helpScreenContent to null",
      () {
        // Arrange
        final Map<String, dynamic> json = {"help_screen_content": null};

        // Act
        final HelpModel model = HelpModel.fromJson(json);

        // Assert
        expect(model.helpScreenContent, isNull);
      },
    );
  });
}
