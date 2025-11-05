import 'package:fitness_app/domain/entities/account/help/title_entity.dart';

class TitleModel {
  final String? en;
  final String? ar;

  TitleModel({this.en, this.ar});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(en: json['en'] as String?, ar: json['ar'] as String?);
  }

  TitleEntity toEntity() => TitleEntity(en: en, ar: ar);
}
