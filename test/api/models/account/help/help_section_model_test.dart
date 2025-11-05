import 'package:fitness_app/api/models/account/help/contact_content_model.dart';
import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/api/models/account/help/help_section_model.dart';
import 'package:fitness_app/api/models/account/help/style_model.dart';
import 'package:fitness_app/api/models/account/help/title_model.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("HelpSectionModel → HelpSectionEntity", () {
    test(
      "when call toEntity with null values it should return HelpSectionEntity with null values",
      () {
        // Arrange
        final HelpSectionModel helpSectionModel = HelpSectionModel(
          section: null,
          content: null,
          title: null,
          style: null,
          contactContent: null,
          faqContent: null,
        );

        // Act
        final HelpSectionEntity actualResult = helpSectionModel.toEntity();

        // Assert
        expect(actualResult.section, equals(helpSectionModel.section));
        expect(
          actualResult.content,
          equals(helpSectionModel.content?.toEntity()),
        );
        expect(actualResult.title, equals(helpSectionModel.title?.toEntity()));
        expect(actualResult.style, equals(helpSectionModel.style?.toEntity()));
        expect(
          actualResult.contactContent,
          equals(helpSectionModel.contactContent),
        );
        expect(actualResult.faqContent, equals(helpSectionModel.faqContent));
      },
    );

    test(
      "when call toEntity with non-null values it should return HelpSectionEntity with correct values",
      () {
        // Arrange
        final HelpSectionModel helpSectionModel = HelpSectionModel(
          section: "contact_us",
          content: ContentModel(en: "en content", ar: "ar content"),
          title: TitleModel(en: "en title", ar: "ar title"),
          style: StyleModel(color: "#FFFFFF", fontSize: 16, fontWeight: "bold"),
          contactContent: [
            ContactContentModel(
              id: "1",
              value: "support@example.com",
              method: ContentModel(en: "email", ar: "البريد الإلكتروني"),
            ),
          ],
          faqContent: null,
        );

        // Act
        final HelpSectionEntity actualResult = helpSectionModel.toEntity();

        // Assert
        expect(actualResult.section, equals(helpSectionModel.section));
        expect(actualResult.content?.en, equals("en content"));
        expect(actualResult.title?.en, equals("en title"));
        expect(actualResult.style?.color, equals("#FFFFFF"));
        expect(actualResult.contactContent?.length, equals(1));
        expect(
          actualResult.contactContent?.first.value,
          equals("support@example.com"),
        );
        expect(actualResult.faqContent, isNull);
      },
    );
  });

  group("HelpSectionModel.fromJson", () {
    test(
      "when section = contact_us it should parse contactContent correctly",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "section": "contact_us",
          "title": {"en": "Contact Us", "ar": "اتصل بنا"},
          "style": {"color": "#000000", "fontSize": 14, "fontWeight": "normal"},
          "content": [
            {
              "id": "1",
              "value": "support@example.com",
              "method": {"en": "email", "ar": "البريد الإلكتروني"},
            },
          ],
        };

        // Act
        final HelpSectionModel model = HelpSectionModel.fromJson(json);

        // Assert
        expect(model.section, equals("contact_us"));
        expect(model.title?.en, equals("Contact Us"));
        expect(model.style?.color, equals("#000000"));
        expect(model.contactContent, isNotNull);
        expect(
          model.contactContent?.first.value,
          equals("support@example.com"),
        );
        expect(model.faqContent, isNull);
      },
    );

    test("when section = faq it should parse faqContent correctly", () {
      // Arrange
      final Map<String, dynamic> json = {
        "section": "faq",
        "title": {"en": "FAQ", "ar": "الأسئلة الشائعة"},
        "style": {"color": "#FF0000", "fontSize": 18, "fontWeight": "bold"},
        "content": [
          {
            "id": "1",
            "question": {"en": "What is this app?", "ar": "ما هذا التطبيق؟"},
            "answer": {
              "en": "It's a fitness app.",
              "ar": "إنه تطبيق لياقة بدنية.",
            },
          },
        ],
      };

      // Act
      final HelpSectionModel model = HelpSectionModel.fromJson(json);

      // Assert
      expect(model.section, equals("faq"));
      expect(model.title?.en, equals("FAQ"));
      expect(model.style?.color, equals("#FF0000"));
      expect(model.faqContent, isNotNull);
      expect(model.faqContent?.first.question?.en, equals("What is this app?"));
      expect(model.contactContent, isNull);
    });

    test("when content is a Map it should parse content as ContentModel", () {
      // Arrange
      final Map<String, dynamic> json = {
        "section": "page_info",
        "content": {"en": "Welcome", "ar": "مرحباً"},
        "title": {"en": "About", "ar": "حول"},
        "style": {"color": "#123456", "fontSize": 12, "fontWeight": "regular"},
      };

      // Act
      final HelpSectionModel model = HelpSectionModel.fromJson(json);

      // Assert
      expect(model.section, equals("page_info"));
      expect(model.content?.en, equals("Welcome"));
      expect(model.title?.ar, equals("حول"));
      expect(model.contactContent, isNull);
      expect(model.faqContent, isNull);
    });
  });
}
