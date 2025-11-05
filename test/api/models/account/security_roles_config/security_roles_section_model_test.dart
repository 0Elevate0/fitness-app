import 'package:fitness_app/api/models/account/privacy_and_security/localized_text_model.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/text_style_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/role_definition_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/security_roles_section_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("SecurityRolesSectionModel → SecurityRolesSectionEntity", () {
    test(
      "when calling toEntity() with null values, it should return SecurityRolesSectionEntity with null fields",
      () {
        // Arrange
        const model = SecurityRolesSectionModel();

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity.section, equals(model.section));
        expect(entity.content, isNull);
        expect(entity.title, isNull);
        expect(entity.style, isNull);
        expect(entity.roleDefinition, isNull);
      },
    );

    test(
      "when calling toEntity() with non-null values, it should return SecurityRolesSectionEntity with correct values",
      () {
        // Arrange
        final model = SecurityRolesSectionModel(
          section: "page_title",
          content: LocalizedTextModel(en: "Content EN", ar: "المحتوى"),
          title: LocalizedTextModel(en: "Title EN", ar: "العنوان"),
          style: TextStyleModel(fontSize: 16, fontWeight: "bold"),
          roleDefinition: const RoleDefinitionModel(roleId: "role_123"),
        );

        // Act
        final entity = model.toEntity();

        // Assert
        expect(entity.section, equals(model.section));
        expect(entity.content?.en, equals(model.content?.en));
        expect(entity.title?.ar, equals(model.title?.ar));
        expect(entity.style?.fontSize, equals(model.style?.fontSize));
        expect(
          entity.roleDefinition?.roleId,
          equals(model.roleDefinition?.roleId),
        );
      },
    );
  });

  group("SecurityRolesSectionModel.fromJson", () {
    test(
      "when json is null, it should return an empty SecurityRolesSectionModel",
      () {
        // Act
        final result = SecurityRolesSectionModel.fromJson(null);

        // Assert
        expect(result.section, isNull);
        expect(result.content, isNull);
        expect(result.title, isNull);
        expect(result.style, isNull);
        expect(result.roleDefinition, isNull);
      },
    );

    test(
      "when section != 'role_definition', it should parse normally and roleDefinition should be null",
      () {
        // Arrange
        final json = {
          "section": "page_title",
          "content": {"en": "Content EN", "ar": "المحتوى"},
          "title": {"en": "Title EN", "ar": "العنوان"},
          "style": {"fontSize": 18, "fontWeight": "bold"},
        };

        // Act
        final result = SecurityRolesSectionModel.fromJson(json);

        // Assert
        expect(result.section, equals("page_title"));
        expect(result.content?.en, equals("Content EN"));
        expect(result.title?.ar, equals("العنوان"));
        expect(result.style?.fontSize, equals(18));
        expect(result.roleDefinition, isNull);
      },
    );

    test(
      "when section == 'role_definition', it should parse and include RoleDefinitionModel",
      () {
        // Arrange
        final json = {
          "section": "role_definition",
          "role_id": "role_001",
          "name": {"en": "Admin", "ar": "مسؤول"},
          "description": {"en": "Full access", "ar": "صلاحيات كاملة"},
          "style": {"fontSize": 14, "fontWeight": "medium"},
          "permissions": [
            {
              "key": "edit_user",
              "name": {"en": "Edit User", "ar": "تعديل المستخدم"},
              "description": {
                "en": "Can edit user data",
                "ar": "يمكنه تعديل بيانات المستخدم",
              },
            },
          ],
        };

        // Act
        final result = SecurityRolesSectionModel.fromJson(json);

        // Assert
        expect(result.section, equals("role_definition"));
        expect(result.roleDefinition, isNotNull);
        expect(result.roleDefinition?.roleId, equals("role_001"));
        expect(result.roleDefinition?.permissions?.length, equals(1));
        expect(
          result.roleDefinition?.permissions?.first.key,
          equals("edit_user"),
        );
      },
    );
  });
}
