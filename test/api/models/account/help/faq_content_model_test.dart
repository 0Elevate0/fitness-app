import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/api/models/account/help/faq_content_model.dart';
import 'package:fitness_app/domain/entities/account/help/faq_content_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("FaqContentModel → FaqContentEntity", () {
    test(
      "when call toEntity with null values it should return FaqContentEntity with null values",
      () {
        // Arrange
        final FaqContentModel faqContentModel = FaqContentModel(
          id: null,
          question: null,
          answer: null,
        );

        // Act
        final FaqContentEntity actualResult = faqContentModel.toEntity();

        // Assert
        expect(actualResult.id, equals(faqContentModel.id));
        expect(
          actualResult.question,
          equals(faqContentModel.question?.toEntity()),
        );
        expect(actualResult.answer, equals(faqContentModel.answer?.toEntity()));
      },
    );

    test(
      "when call toEntity with non-null values it should return FaqContentEntity with correct values",
      () {
        // Arrange
        final FaqContentModel faqContentModel = FaqContentModel(
          id: "1",
          question: ContentModel(en: "What is Flutter?", ar: "ما هو Flutter؟"),
          answer: ContentModel(
            en: "A UI toolkit by Google",
            ar: "أداة واجهة من Google",
          ),
        );

        // Act
        final FaqContentEntity actualResult = faqContentModel.toEntity();

        // Assert
        expect(actualResult.id, equals(faqContentModel.id));
        expect(actualResult.question?.en, equals(faqContentModel.question?.en));
        expect(actualResult.question?.ar, equals(faqContentModel.question?.ar));
        expect(actualResult.answer?.en, equals(faqContentModel.answer?.en));
        expect(actualResult.answer?.ar, equals(faqContentModel.answer?.ar));
      },
    );
  });

  group("FaqContentModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should correctly parse the data",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "id": "123",
          "question": {
            "en": "How to contact support?",
            "ar": "كيف أتواصل مع الدعم؟",
          },
          "answer": {
            "en": "You can reach us via email.",
            "ar": "يمكنك التواصل معنا عبر البريد الإلكتروني.",
          },
        };

        // Act
        final FaqContentModel model = FaqContentModel.fromJson(json);

        // Assert
        expect(model.id, equals("123"));
        expect(model.question?.en, equals("How to contact support?"));
        expect(model.question?.ar, equals("كيف أتواصل مع الدعم؟"));
        expect(model.answer?.en, equals("You can reach us via email."));
        expect(
          model.answer?.ar,
          equals("يمكنك التواصل معنا عبر البريد الإلكتروني."),
        );
      },
    );

    test(
      "when call fromJson with null nested values it should set fields to null",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "id": null,
          "question": null,
          "answer": null,
        };

        // Act
        final FaqContentModel model = FaqContentModel.fromJson(json);

        // Assert
        expect(model.id, isNull);
        expect(model.question, isNull);
        expect(model.answer, isNull);
      },
    );
  });
}
