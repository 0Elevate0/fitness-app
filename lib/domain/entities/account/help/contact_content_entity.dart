import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';

final class ContactContentEntity extends Equatable {
  final String? id;
  final ContentEntity? method;
  final ContentEntity? details;
  final String? value;
  final StyleEntity? style;

  const ContactContentEntity({
    this.id,
    this.method,
    this.details,
    this.value,
    this.style,
  });

  @override
  List<Object?> get props => [id, method, details, value, style];
}
