import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/permission_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/role_definition_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("RoleDefinitionModel → RoleDefinitionEntity", () {
    test(
      "when call toEntity with null values it should return RoleDefinitionEntity with null values",
      () {
        // Arrange
        const RoleDefinitionModel model = RoleDefinitionModel(
          roleId: null,
          name: null,
          description: null,
          style: null,
          permissions: null,
        );

        // Act
        final RoleDefinitionEntity actualResult = model.toEntity();

        // Assert
        expect(actualResult.roleId, equals(model.roleId));
        expect(actualResult.name, equals(model.name?.toEntity()));
        expect(actualResult.description, equals(model.description?.toEntity()));
        expect(actualResult.style, equals(model.style));
        expect(
          actualResult.permissions,
          equals(model.permissions?.map((e) => e.toEntity()).toList()),
        );
      },
    );

    test(
      "when call toEntity with non-null values it should return RoleDefinitionEntity with correct values",
      () {
        // Arrange
        final roleDefinitionModel = RoleDefinitionModel(
          roleId: "admin_01",
          name: LocalizedTextModel(en: "Admin", ar: "مشرف"),
          description: LocalizedTextModel(
            en: "Full access",
            ar: "صلاحية كاملة",
          ),
          style: {"color": "#FF0000", "fontWeight": "bold"},
          permissions: [
            PermissionModel(
              key: "view_users",
              name: LocalizedTextModel(en: "View Users", ar: "عرض المستخدمين"),
              description: LocalizedTextModel(
                en: "Allows viewing users",
                ar: "يسمح بعرض المستخدمين",
              ),
            ),
          ],
        );

        // Act
        final RoleDefinitionEntity actualResult = roleDefinitionModel
            .toEntity();

        // Assert
        expect(actualResult.roleId, equals(roleDefinitionModel.roleId));
        expect(actualResult.name?.en, equals(roleDefinitionModel.name?.en));
        expect(
          actualResult.description?.ar,
          equals(roleDefinitionModel.description?.ar),
        );
        expect(actualResult.style, equals(roleDefinitionModel.style));
        expect(actualResult.permissions?.length, equals(1));
        expect(
          actualResult.permissions?.first.key,
          equals(roleDefinitionModel.permissions?.first.key),
        );
      },
    );
  });

  group("RoleDefinitionModel.fromJson", () {
    test(
      "when call fromJson with valid JSON it should return correct RoleDefinitionModel",
      () {
        // Arrange
        final Map<String, dynamic> json = {
          "role_id": "manager_01",
          "name": {"en": "Manager", "ar": "مدير"},
          "description": {
            "en": "Can manage resources",
            "ar": "يمكنه إدارة الموارد",
          },
          "style": {"color": "#00FF00", "fontWeight": "normal"},
          "permissions": [
            {
              "key": "edit_roles",
              "name": {"en": "Edit Roles", "ar": "تعديل الأدوار"},
              "description": {
                "en": "Allows editing roles",
                "ar": "يسمح بتعديل الأدوار",
              },
            },
          ],
        };

        // Act
        final RoleDefinitionModel actualResult = RoleDefinitionModel.fromJson(
          json,
        );

        // Assert
        expect(actualResult.roleId, equals("manager_01"));
        expect(actualResult.name?.en, equals("Manager"));
        expect(actualResult.name?.ar, equals("مدير"));
        expect(actualResult.description?.en, equals("Can manage resources"));
        expect(actualResult.style?["color"], equals("#00FF00"));
        expect(actualResult.permissions?.first.key, equals("edit_roles"));
        expect(
          actualResult.permissions?.first.name?.ar,
          equals("تعديل الأدوار"),
        );
      },
    );

    test(
      "when call fromJson with null it should return empty RoleDefinitionModel",
      () {
        // Act
        final RoleDefinitionModel actualResult = RoleDefinitionModel.fromJson(
          null,
        );

        // Assert
        expect(actualResult.roleId, isNull);
        expect(actualResult.name, isNull);
        expect(actualResult.description, isNull);
        expect(actualResult.style, isNull);
        expect(actualResult.permissions, isNull);
      },
    );
  });
}
