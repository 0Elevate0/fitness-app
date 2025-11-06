import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/presentation/privacy_policy/views/widgets/privacy_policy_view_body.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_cubit.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_view_body_test.mocks.dart';

@GenerateMocks([PrivacyPolicyCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPrivacyPolicyCubit mockPrivacyPolicyCubit;
  late MockGlobalCubit mockGlobalCubit;
  late PrivacyPolicyEntity privacyPolicyData;
  setUp(() {
    mockPrivacyPolicyCubit = MockPrivacyPolicyCubit();
    getIt.registerFactory<PrivacyPolicyCubit>(() => mockPrivacyPolicyCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<PrivacyPolicyState>(const PrivacyPolicyState());
    when(mockPrivacyPolicyCubit.state).thenReturn(const PrivacyPolicyState());
    when(
      mockPrivacyPolicyCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const PrivacyPolicyState()]));

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  setUpAll(() {
    privacyPolicyData = const PrivacyPolicyEntity(
      sections: [
        PrivacySectionEntity(section: "title"),
        PrivacySectionEntity(section: "page_subtitle"),
        PrivacySectionEntity(
          section: "contact_us",
          title: LocalizedTextEntity(en: "data", ar: "data"),
          content: LocalizedTextEntity(en: "data", ar: "data"),
          subSections: [
            PrivacySubSectionEntity(
              title: LocalizedTextEntity(en: "data", ar: "data"),
              content: LocalizedTextEntity(en: "data", ar: "data"),
            ),
          ],
        ),
        PrivacySectionEntity(section: "changes_to_policy"),
        PrivacySectionEntity(
          section: "introduction",
          title: LocalizedTextEntity(en: "Introduction", ar: "مقدمة"),
          content: LocalizedTextEntity(
            en: "Welcome to Apex Fitness. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your data.",
            ar: "مرحبًا بك في أبيكس فيتنس. خصوصيتك مهمة بالنسبة لنا. توضح سياسة الخصوصية هذه كيفية جمع بياناتك واستخدامها وحمايتها.",
          ),
          style: TextStyleEntity(
            fontSize: 18,
            fontWeight: "bold",
            color: "#FFFFFF",
            backgroundColor: "#121212",
            textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
          ),
        ),
        PrivacySectionEntity(
          section: "data_usage",
          title: LocalizedTextEntity(
            en: "How We Use Your Data",
            ar: "كيفية استخدام بياناتك",
          ),
          content: LocalizedTextEntity(
            en: "We use your data to personalize your workout plans, track your progress, and improve our AI recommendations.",
            ar: "نستخدم بياناتك لتخصيص خطط التمرين الخاصة بك، وتتبع تقدمك، وتحسين توصيات الذكاء الاصطناعي لدينا.",
          ),
          style: TextStyleEntity(
            fontSize: 16,
            fontWeight: "normal",
            color: "#CCCCCC",
            backgroundColor: "#1E1E1E",
            textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
          ),
          subSections: [
            PrivacySubSectionEntity(
              type: "data_collection",
              title: LocalizedTextEntity(
                en: "Data We Collect",
                ar: "البيانات التي نجمعها",
              ),
              content: LocalizedTextEntity(
                en: "We collect information such as your age, weight, goals, and activity logs to tailor your experience.",
                ar: "نجمع معلومات مثل عمرك ووزنك وأهدافك وسجل نشاطك لتخصيص تجربتك.",
              ),
            ),
            PrivacySubSectionEntity(
              type: "data_sharing",
              title: LocalizedTextEntity(
                en: "Data Sharing",
                ar: "مشاركة البيانات",
              ),
              content: LocalizedTextEntity(
                en: "Your data is never sold. It is shared only with trusted partners to provide key app functionalities.",
                ar: "لن يتم بيع بياناتك أبدًا. تتم مشاركتها فقط مع شركاء موثوقين لتقديم وظائف أساسية في التطبيق.",
              ),
            ),
          ],
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
              BlocProvider<PrivacyPolicyCubit>.value(
                value: mockPrivacyPolicyCubit,
              ),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const PrivacyPolicyViewBody(),
          ),
        );
      },
    );
  }

  testWidgets(
    "Verifying PrivacyPolicyViewBody Widgets on Initial/Loading state",
    (tester) async {
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(
        find.byType(BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>),
        findsOneWidget,
      );
      expect(find.byType(LoadingView), findsOneWidget);
    },
  );

  testWidgets("Verifying PrivacyPolicyViewBody Widgets on Success state", (
    tester,
  ) async {
    // Arrange
    when(mockPrivacyPolicyCubit.state).thenReturn(
      PrivacyPolicyState(
        privacyPolicyStatus: StateStatus.success(privacyPolicyData),
      ),
    );
    when(mockPrivacyPolicyCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        PrivacyPolicyState(
          privacyPolicyStatus: StateStatus.success(privacyPolicyData),
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>),
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
    expect(find.byType(Visibility), findsWidgets);
    expect(find.byType(ExpansionTile), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
