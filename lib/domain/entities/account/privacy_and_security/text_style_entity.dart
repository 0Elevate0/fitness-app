import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';

final class TextStyleEntity extends Equatable {
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final double? contentFontSize;
  final String? contentFontWeight;
  final String? contentColor;
  final LocalizedTextAlignEntity? textAlign;
  final String? backgroundColor;
  final String? highlightColor;

  const TextStyleEntity({
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

  @override
  List<Object?> get props => [
    fontSize,
    fontWeight,
    color,
    contentFontSize,
    contentFontWeight,
    contentColor,
    textAlign,
    backgroundColor,
    highlightColor,
  ];
}
