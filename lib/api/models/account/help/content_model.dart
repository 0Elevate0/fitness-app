import 'package:fitness_app/domain/entities/account/help/content_entity.dart';

class ContentModel {
  final String? en;
  final String? ar;

  ContentModel({this.en, this.ar});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(en: json['en'] as String?, ar: json['ar'] as String?);
  }

  ContentEntity toEntity() => ContentEntity(en: en, ar: ar);
}
