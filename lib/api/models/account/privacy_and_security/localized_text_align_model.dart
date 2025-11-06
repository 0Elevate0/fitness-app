import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';

class LocalizedTextAlignModel {
  final String? en;
  final String? ar;

  LocalizedTextAlignModel({this.en, this.ar});

  static LocalizedTextAlignModel empty() => LocalizedTextAlignModel();

  factory LocalizedTextAlignModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return LocalizedTextAlignModel(
        en: json['en'] as String?,
        ar: json['ar'] as String?,
      );
    }
    return empty();
  }

  LocalizedTextAlignEntity toEntity() {
    return LocalizedTextAlignEntity(en: en, ar: ar);
  }
}
