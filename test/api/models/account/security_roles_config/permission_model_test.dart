import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/permission_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("PermissionModel → PermissionEntity", () {
    test(
      "when call toEntity with null values it should return PermissionEntity with null values",
      () {
        // Arrange
        final PermissionModel permissionModel = const PermissionModel(
          key: null,
          name: null,
          description: null,
        );

        // Act
        final PermissionEntity actualResult = permissionModel.toEntity();

        // Assert
        expect(actualResult.key, equals(permissionModel.key));
        expect(actualResult.name, equals(permissionModel.name?.toEntity()));
        expect(
          actualResult.description,
          equals(permissionModel.description?.toEntity()),
        );
      },
    );

    test(
      "when call toEntity with non-null values it should return PermissionEntity with correct values",
      () {
        // Arrange
        final permissionModel = PermissionModel(
          key: "view_users",
          name: LocalizedTextModel(en: "View Users", ar: "عرض المستخدمين"),
          description: LocalizedTextModel(
            en: "Allows viewing user list",
            ar: "يسمح بعرض قائمة المستخدمين",
          ),
        );

        // Act
        final PermissionEntity actualResult = permissionModel.toEntity();

        // Assert
        expect(actualResult.key, equals(permissionModel.key));
        expect(actualResult.name?.en, equals(permissionModel.name?.en));
        expect(actualResult.name?.ar, equals(permissionModel.name?.ar));
        expect(
          actualResult.description?.en,
          equals(permissionModel.description?.en),
        );
        expect(
          actualResult.description?.ar,
          equals(permissionModel.description?.ar),
        );
      },
    );
  });

  group("PermissionModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct PermissionModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "key": "edit_roles",
          "name": {"en": "Edit Roles", "ar": "تعديل الأدوار"},
          "description": {
            "en": "Allows editing roles",
            "ar": "يسمح بتعديل الأدوار",
          },
        };

        // Act
        final PermissionModel actualResult = PermissionModel.fromJson(json);

        // Assert
        expect(actualResult.key, equals("edit_roles"));
        expect(actualResult.name?.en, equals("Edit Roles"));
        expect(actualResult.name?.ar, equals("تعديل الأدوار"));
        expect(actualResult.description?.en, equals("Allows editing roles"));
        expect(actualResult.description?.ar, equals("يسمح بتعديل الأدوار"));
      },
    );

    test(
      "when call fromJson with null it should return empty PermissionModel",
      () {
        // Act
        final PermissionModel actualResult = PermissionModel.fromJson(null);

        // Assert
        expect(actualResult.key, isNull);
        expect(actualResult.name, isNull);
        expect(actualResult.description, isNull);
      },
    );
  });
}
