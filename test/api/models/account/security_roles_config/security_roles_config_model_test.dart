import 'package:fitness_app/api/models/account/security_roles_config/security_roles_config_model.dart';
import 'package:fitness_app/api/models/account/security_roles_config/security_roles_section_model.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("SecurityRolesConfigModel → SecurityRolesConfigEntity", () {
    test(
      "when calling toEntity with null sections it should return SecurityRolesConfigEntity with null sections",
      () {
        // Arrange
        const SecurityRolesConfigModel model = SecurityRolesConfigModel(
          sections: null,
        );

        // Act
        final SecurityRolesConfigEntity result = model.toEntity();

        // Assert
        expect(result.sections, equals(model.sections));
      },
    );

    test(
      "when calling toEntity with non-null sections it should map correctly to SecurityRolesConfigEntity",
      () {
        // Arrange
        final sectionModel = const SecurityRolesSectionModel(
          section: "page_title",
        );
        final model = SecurityRolesConfigModel(sections: [sectionModel]);

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.sections?.length, equals(1));
        expect(result.sections?.first.section, equals("page_title"));
      },
    );
  });

  group("SecurityRolesConfigModel.fromJson", () {
    test(
      "when json is null it should return an empty SecurityRolesConfigModel",
      () {
        // Act
        final model = SecurityRolesConfigModel.fromJson(null);

        // Assert
        expect(model.sections, isNull);
      },
    );

    test(
      "when json contains valid data it should correctly parse to SecurityRolesConfigModel",
      () {
        // Arrange
        final json = {
          "security_roles_config": [
            {
              "section": "page_title",
              "content": {
                "en": "User Roles & Permissions",
                "ar": "أدوار وصلاحيات المستخدمين",
              },
              "title": {"en": "Title EN", "ar": "العنوان"},
              "style": {"fontSize": 24, "fontWeight": "bold"},
            },
            {
              "section": "role_definition",
              "role_id": "admin",
              "name": {"en": "Administrator", "ar": "مدير النظام"},
              "description": {"en": "Full control", "ar": "تحكم كامل"},
              "permissions": [
                {
                  "key": "manage_users",
                  "name": {"en": "Manage Users", "ar": "إدارة المستخدمين"},
                  "description": {
                    "en": "Can manage all users",
                    "ar": "يمكنه إدارة جميع المستخدمين",
                  },
                },
              ],
              "style": {"fontSize": 16, "fontWeight": "medium"},
            },
          ],
        };

        // Act
        final model = SecurityRolesConfigModel.fromJson(json);

        // Assert
        expect(model.sections, isNotNull);
        expect(model.sections?.length, equals(2));

        final firstSection = model.sections!.first;
        expect(firstSection.section, equals("page_title"));
        expect(firstSection.content?.en, equals("User Roles & Permissions"));
        expect(firstSection.style?.fontSize, equals(24));

        final secondSection = model.sections!.last;
        expect(secondSection.section, equals("role_definition"));
        expect(secondSection.roleDefinition?.roleId, equals("admin"));
        expect(
          secondSection.roleDefinition?.permissions?.first.key,
          equals("manage_users"),
        );
      },
    );
  });
}
