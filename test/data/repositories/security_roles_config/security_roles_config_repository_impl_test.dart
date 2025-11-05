import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/security_roles_config/local_data_source/security_roles_config_local_data_source.dart';
import 'package:fitness_app/data/repositories/security_roles_config/security_roles_config_repository_impl.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_roles_config_repository_impl_test.mocks.dart';

@GenerateMocks([SecurityRolesConfigLocalDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call fetchSecurityRolesConfigData it should be called successfully from SecurityRolesConfigLocalDataSource and return SecurityRolesConfigEntity',
    () async {
      // Arrange
      final mockedSecurityRolesConfigLocalDataSource =
          MockSecurityRolesConfigLocalDataSource();

      final expectedSecurityData = const SecurityRolesConfigEntity(
        sections: [
          SecurityRolesSectionEntity(
            section: "admin_role",
            title: LocalizedTextEntity(
              en: "Administrator Role",
              ar: "دور المسؤول",
            ),
            content: LocalizedTextEntity(
              en: "Administrators have full access to manage users and system settings.",
              ar: "يتمتع المسؤولون بإمكانية الوصول الكامل لإدارة المستخدمين وإعدادات النظام.",
            ),
            style: TextStyleEntity(
              fontSize: 18,
              fontWeight: "bold",
              color: "#FFFFFF",
              backgroundColor: "#0A0A0A",
              textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
            ),
            roleDefinition: RoleDefinitionEntity(
              roleId: "admin",
              name: LocalizedTextEntity(
                en: "Administrator",
                ar: "مسؤول النظام",
              ),
              description: LocalizedTextEntity(
                en: "Can access all parts of the application.",
                ar: "يمكنه الوصول إلى جميع أجزاء التطبيق.",
              ),
              style: {"color": "#FF4100", "fontWeight": "bold"},
              permissions: [
                PermissionEntity(
                  key: "manage_users",
                  name: LocalizedTextEntity(
                    en: "Manage Users",
                    ar: "إدارة المستخدمين",
                  ),
                  description: LocalizedTextEntity(
                    en: "Add, remove, and update user accounts.",
                    ar: "إضافة وحذف وتحديث حسابات المستخدمين.",
                  ),
                ),
                PermissionEntity(
                  key: "access_settings",
                  name: LocalizedTextEntity(
                    en: "Access Settings",
                    ar: "الوصول إلى الإعدادات",
                  ),
                  description: LocalizedTextEntity(
                    en: "Modify global application configurations.",
                    ar: "تعديل إعدادات التطبيق العامة.",
                  ),
                ),
              ],
            ),
          ),

          SecurityRolesSectionEntity(
            section: "user_role",
            title: LocalizedTextEntity(en: "User Role", ar: "دور المستخدم"),
            content: LocalizedTextEntity(
              en: "Regular users can view and update their personal information.",
              ar: "يمكن للمستخدمين العاديين عرض وتحديث معلوماتهم الشخصية.",
            ),
            style: TextStyleEntity(
              fontSize: 16,
              fontWeight: "normal",
              color: "#CCCCCC",
              backgroundColor: "#1A1A1A",
              textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
            ),
            roleDefinition: RoleDefinitionEntity(
              roleId: "user",
              name: LocalizedTextEntity(en: "User", ar: "مستخدم"),
              description: LocalizedTextEntity(
                en: "Has limited access to app features.",
                ar: "لديه صلاحيات محدودة للوصول إلى ميزات التطبيق.",
              ),
              style: {"color": "#00BFA6", "fontWeight": "normal"},
              permissions: [
                PermissionEntity(
                  key: "view_profile",
                  name: LocalizedTextEntity(
                    en: "View Profile",
                    ar: "عرض الملف الشخصي",
                  ),
                  description: LocalizedTextEntity(
                    en: "Can view personal profile details.",
                    ar: "يمكنه عرض تفاصيل الملف الشخصي.",
                  ),
                ),
                PermissionEntity(
                  key: "update_profile",
                  name: LocalizedTextEntity(
                    en: "Update Profile",
                    ar: "تحديث الملف الشخصي",
                  ),
                  description: LocalizedTextEntity(
                    en: "Can update personal data and preferences.",
                    ar: "يمكنه تحديث البيانات الشخصية والتفضيلات.",
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      final securityRolesConfigRepositoryImpl =
          SecurityRolesConfigRepositoryImpl(
            mockedSecurityRolesConfigLocalDataSource,
          );
      final expectedSecurityRolesConfigEntityResult =
          Success<SecurityRolesConfigEntity>(expectedSecurityData);
      provideDummy<Result<SecurityRolesConfigEntity>>(
        expectedSecurityRolesConfigEntityResult,
      );
      when(
        mockedSecurityRolesConfigLocalDataSource.fetchSecurityRolesConfigData(),
      ).thenAnswer((_) async => expectedSecurityRolesConfigEntityResult);

      // Act
      final result = await securityRolesConfigRepositoryImpl
          .fetchSecurityRolesConfigData();

      // Assert
      verify(
        mockedSecurityRolesConfigLocalDataSource.fetchSecurityRolesConfigData(),
      ).called(1);
      expect(result, isA<Success<SecurityRolesConfigEntity>>());
      final successResult = result as Success<SecurityRolesConfigEntity>;
      expect(
        successResult.data,
        equals(expectedSecurityRolesConfigEntityResult.data),
      );
      expect(
        successResult.data.sections,
        equals(expectedSecurityRolesConfigEntityResult.data.sections),
      );
      expect(
        successResult.data.sections?.elementAt(0),
        equals(
          expectedSecurityRolesConfigEntityResult.data.sections?.elementAt(0),
        ),
      );
      expect(
        successResult.data.sections?.elementAt(1),
        equals(
          expectedSecurityRolesConfigEntityResult.data.sections?.elementAt(1),
        ),
      );
    },
  );
}
