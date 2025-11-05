import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/domain/entities/account/help/faq_content_entity.dart';

class FaqContentModel {
  final String? id;
  final ContentModel? question;
  final ContentModel? answer;

  FaqContentModel({this.id, this.question, this.answer});

  factory FaqContentModel.fromJson(Map<String, dynamic> json) {
    return FaqContentModel(
      id: json['id'] as String?,
      question: json['question'] != null
          ? ContentModel.fromJson(json['question'])
          : null,
      answer: json['answer'] != null
          ? ContentModel.fromJson(json['answer'])
          : null,
    );
  }

  FaqContentEntity toEntity() {
    return FaqContentEntity(
      id: id,
      question: question?.toEntity(),
      answer: answer?.toEntity(),
    );
  }
}
