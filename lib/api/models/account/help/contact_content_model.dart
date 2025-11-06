import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/api/models/account/help/style_model.dart';
import 'package:fitness_app/domain/entities/account/help/contact_content_entity.dart';

class ContactContentModel {
  final String? id;
  final ContentModel? method;
  final ContentModel? details;
  final String? value;
  final StyleModel? style;

  ContactContentModel({
    this.id,
    this.method,
    this.details,
    this.value,
    this.style,
  });

  factory ContactContentModel.fromJson(Map<String, dynamic> json) {
    return ContactContentModel(
      id: json['id'] as String?,
      method: json['method'] != null
          ? ContentModel.fromJson(json['method'])
          : null,
      details: json['details'] != null
          ? ContentModel.fromJson(json['details'])
          : null,
      value: json['value'] as String?,
      style: json['style'] != null ? StyleModel.fromJson(json['style']) : null,
    );
  }

  ContactContentEntity toEntity() {
    return ContactContentEntity(
      id: id,
      method: method?.toEntity(),
      details: details?.toEntity(),
      value: value,
      style: style?.toEntity(),
    );
  }
}
