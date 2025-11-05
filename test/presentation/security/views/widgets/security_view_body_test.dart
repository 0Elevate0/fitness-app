import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';
import 'package:fitness_app/presentation/security/views/widgets/security_view_body.dart';
import 'package:fitness_app/presentation/security/views_model/security_cubit.dart';
import 'package:fitness_app/presentation/security/views_model/security_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_view_body_test.mocks.dart';

@GenerateMocks([SecurityCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSecurityCubit mockSecurityCubit;
  late MockGlobalCubit mockGlobalCubit;
  late SecurityRolesConfigEntity securityData;
  setUp(() {
    mockSecurityCubit = MockSecurityCubit();
    getIt.registerFactory<SecurityCubit>(() => mockSecurityCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<SecurityState>(const SecurityState());
    when(mockSecurityCubit.state).thenReturn(const SecurityState());
    when(
      mockSecurityCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const SecurityState()]));

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  setUpAll(() {
    securityData = const SecurityRolesConfigEntity(
      sections: [
        SecurityRolesSectionEntity(section: "page_title"),
        SecurityRolesSectionEntity(
          section: "page_description",
          title: LocalizedTextEntity(en: "description", ar: "description"),
          content: LocalizedTextEntity(en: "description", ar: "description"),
        ),
        SecurityRolesSectionEntity(
          section: "role_list_title",
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
            name: LocalizedTextEntity(en: "Administrator", ar: "مسؤول النظام"),
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
          section: "role_definition",
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
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<SecurityCubit>.value(value: mockSecurityCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const SecurityViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SecurityViewBody Widgets on Initial/Loading state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocConsumer<SecurityCubit, SecurityState>),
      findsOneWidget,
    );
    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets("Verifying SecurityViewBody Widgets on Success state", (
    tester,
  ) async {
    // Arrange
    when(mockSecurityCubit.state).thenReturn(
      SecurityState(securityStatus: StateStatus.success(securityData)),
    );
    when(mockSecurityCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        SecurityState(securityStatus: StateStatus.success(securityData)),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocConsumer<SecurityCubit, SecurityState>),
      findsOneWidget,
    );
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(ExpansionTile), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
