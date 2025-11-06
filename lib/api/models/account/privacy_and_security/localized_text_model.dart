import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';

class LocalizedTextModel {
  final dynamic en;
  final dynamic ar;

  LocalizedTextModel({this.en, this.ar});

  static LocalizedTextModel empty() => LocalizedTextModel(en: null, ar: null);

  factory LocalizedTextModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      dynamic parseContent(dynamic value) {
        if (value is List) {
          return value.join('\n');
        }
        return value;
      }

      return LocalizedTextModel(
        en: parseContent(json['en']),
        ar: parseContent(json['ar']),
      );
    }
    return empty();
  }

  LocalizedTextEntity toEntity() {
    return LocalizedTextEntity(
      en: en is List ? (en as List).join('\n') : en,
      ar: ar is List ? (ar as List).join('\n') : ar,
    );
  }
}
