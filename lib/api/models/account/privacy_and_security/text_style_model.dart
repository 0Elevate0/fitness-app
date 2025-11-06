import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_align_model.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';

class TextStyleModel {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final double? contentFontSize;
  final String? contentFontWeight;
  final String? contentColor;
  final LocalizedTextAlignModel? textAlign;
  final String? backgroundColor;
  final String? highlightColor;

  TextStyleModel({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.contentFontSize,
    this.contentFontWeight,
    this.contentColor,
    this.textAlign,
    this.backgroundColor,
    this.highlightColor,
  });

  factory TextStyleModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('title')) {
      return TextStyleModel.fromJson(json['title']);
    }

    return TextStyleModel(
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight'] as String?,
      color: json['color'] as String?,
      contentFontSize: (json['contentFontSize'] as num?)?.toDouble(),
      contentFontWeight: json['contentFontWeight'] as String?,
      contentColor: json['contentColor'] as String?,
      textAlign: json['textAlign'] != null
          ? LocalizedTextAlignModel.fromJson(json['textAlign'])
          : null,
      backgroundColor: json['backgroundColor'] as String?,
      highlightColor: json['highlightColor'] as String?,
    );
  }

  TextStyleEntity toEntity() {
    return TextStyleEntity(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      contentFontSize: contentFontSize,
      contentFontWeight: contentFontWeight,
      contentColor: contentColor,
      textAlign: textAlign?.toEntity(),
      backgroundColor: backgroundColor,
      highlightColor: highlightColor,
    );
  }
}
