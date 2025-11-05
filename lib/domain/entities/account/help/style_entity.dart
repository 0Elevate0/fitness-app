import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';

final class StyleEntity extends Equatable {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final String? backgroundColor;
  final LocalizedTextAlignEntity? textAlign;
  final Map<String, StyleEntity>? nestedStyles;

  const StyleEntity({
    this.fontSize,
    this.fontWeight,
    this.color,
    this.backgroundColor,
    this.textAlign,
    this.nestedStyles,
  });

  @override
  List<Object?> get props => [
    fontSize,
    fontWeight,
    color,
    backgroundColor,
    textAlign,
    nestedStyles,
  ];
}
