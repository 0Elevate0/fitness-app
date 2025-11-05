import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';

class PermissionModel {
  final String? key;
  final LocalizedTextModel? name;
  final LocalizedTextModel? description;

  const PermissionModel({this.key, this.name, this.description});

  static PermissionModel empty() => const PermissionModel();

  factory PermissionModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return empty();
    return PermissionModel(
      key: json['key'] as String?,
      name: LocalizedTextModel.fromJson(json['name']),
      description: LocalizedTextModel.fromJson(json['description']),
    );
  }

  PermissionEntity toEntity() => PermissionEntity(
    key: key,
    name: name?.toEntity(),
    description: description?.toEntity(),
  );
}
