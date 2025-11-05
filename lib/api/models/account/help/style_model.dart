import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_align_model.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';

class StyleModel {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final String? backgroundColor;
  final LocalizedTextAlignModel? textAlign;
  final Map<String, StyleModel>? nestedStyles;

  StyleModel({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.backgroundColor,
    this.textAlign,
    this.nestedStyles,
  });

  factory StyleModel.fromJson(Map<String, dynamic> json) {
    final nestedStyles = <String, StyleModel>{};

    json.forEach((key, value) {
      if (value is Map<String, dynamic> && _isStyleMap(value)) {
        nestedStyles[key] = StyleModel.fromJson(value);
      } else if (value is Map) {
        final mapValue = Map<String, dynamic>.from(value);
        if (_isStyleMap(mapValue)) {
          nestedStyles[key] = StyleModel.fromJson(mapValue);
        }
      }
    });

    return StyleModel(
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight: json['fontWeight'] as String?,
      color: json['color'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      textAlign: LocalizedTextAlignModel.fromJson(json['textAlign']),
      nestedStyles: nestedStyles.isEmpty ? null : nestedStyles,
    );
  }

  StyleEntity toEntity() {
    return StyleEntity(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      backgroundColor: backgroundColor,
      textAlign: textAlign?.toEntity(),
      nestedStyles: nestedStyles?.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
    );
  }

  static bool _isStyleMap(Map<String, dynamic> map) {
    const keys = [
      'fontSize',
      'fontWeight',
      'color',
      'backgroundColor',
      'textAlign',
    ];
    return map.keys.any(keys.contains);
  }
}
