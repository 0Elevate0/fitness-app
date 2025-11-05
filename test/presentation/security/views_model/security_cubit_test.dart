import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';
import 'package:fitness_app/domain/use_cases/security_roles_config/security_roles_config_use_case.dart';
import 'package:fitness_app/presentation/security/views_model/security_cubit.dart';
import 'package:fitness_app/presentation/security/views_model/security_intent.dart';
import 'package:fitness_app/presentation/security/views_model/security_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_cubit_test.mocks.dart';

@GenerateMocks([SecurityRolesConfigUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSecurityRolesConfigUseCase mockSecurityRolesConfigUseCase;
  late SecurityCubit cubit;
  late Result<SecurityRolesConfigEntity> expectedSuccessResult;
  late Failure<SecurityRolesConfigEntity> expectedFailureResult;
  late SecurityRolesConfigEntity expectedSecurityData;

  setUpAll(() {
    mockSecurityRolesConfigUseCase = MockSecurityRolesConfigUseCase();
  });
  setUp(() {
    cubit = SecurityCubit(mockSecurityRolesConfigUseCase);
  });

  group("Security cubit test", () {
    blocTest<SecurityCubit, SecurityState>(
      'emits [Loading, Success] when FetchSecurityDataIntent succeeds',
      build: () {
        expectedSecurityData = const SecurityRolesConfigEntity(
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
        expectedSuccessResult = Success<SecurityRolesConfigEntity>(
          expectedSecurityData,
        );
        provideDummy<Result<SecurityRolesConfigEntity>>(expectedSuccessResult);
        when(
          mockSecurityRolesConfigUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchSecurityDataIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<SecurityState>()
            .having(
              (state) => state.securityStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.securityStatus.data,
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<SecurityRolesConfigEntity>)
                    .data,
              ),
            )
            .having(
              (state) => state.securityStatus.data?.sections,
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<SecurityRolesConfigEntity>)
                    .data
                    .sections,
              ),
            )
            .having(
              (state) => state.securityStatus.data?.sections?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<SecurityRolesConfigEntity>)
                    .data
                    .sections
                    ?.elementAt(0),
              ),
            )
            .having(
              (state) => state.securityStatus.data?.sections?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<SecurityRolesConfigEntity>)
                    .data
                    .sections
                    ?.elementAt(1),
              ),
            ),
      ],
      verify: (_) {
        verify(mockSecurityRolesConfigUseCase.invoke()).called(1);
      },
    );

    blocTest<SecurityCubit, SecurityState>(
      "emits [Loading, Failure] when FetchSecurityDataIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to load privacy data",
          ),
        );

        provideDummy<Result<SecurityRolesConfigEntity>>(expectedFailureResult);
        when(
          mockSecurityRolesConfigUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchSecurityDataIntent()),
      expect: () => [
        isA<SecurityState>().having(
          (state) => state.securityStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<SecurityState>()
            .having(
              (state) => state.securityStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.securityStatus.error?.message,
              'responseException.message',
              equals(expectedFailureResult.responseException.message),
            ),
      ],
      verify: (_) {
        verify(mockSecurityRolesConfigUseCase.invoke()).called(1);
      },
    );
  });
}
