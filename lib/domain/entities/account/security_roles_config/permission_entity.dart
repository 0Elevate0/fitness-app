import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';

final class PermissionEntity extends Equatable {
  final String? key;
  final LocalizedTextEntity? name;
  final LocalizedTextEntity? description;

  const PermissionEntity({this.key, this.name, this.description});

  @override
  List<Object?> get props => [key, name, description];
}
