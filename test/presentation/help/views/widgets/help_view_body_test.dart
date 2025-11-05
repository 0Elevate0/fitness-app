import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/help/contact_content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/faq_content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/presentation/help/views/widgets/help_view_body.dart';
import 'package:fitness_app/presentation/help/views_model/help_cubit.dart';
import 'package:fitness_app/presentation/help/views_model/help_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_view_body_test.mocks.dart';

@GenerateMocks([HelpCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHelpCubit mockHelpCubit;
  late MockGlobalCubit mockGlobalCubit;
  late HelpEntity helpData;
  setUp(() {
    mockHelpCubit = MockHelpCubit();
    getIt.registerFactory<HelpCubit>(() => mockHelpCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<HelpState>(const HelpState());
    when(mockHelpCubit.state).thenReturn(const HelpState());
    when(
      mockHelpCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HelpState()]));

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  setUpAll(() {
    helpData = const HelpEntity(
      helpScreenContent: [
        HelpSectionEntity(
          section: "page_title",
          content: ContentEntity(en: "Help & Support", ar: "المساعدة والدعم"),
          style: StyleEntity(
            fontSize: 24,
            fontWeight: "bold",
            color: "#FFFFFF",
            backgroundColor: "#121212",
            textAlign: LocalizedTextAlignEntity(en: "center", ar: "center"),
          ),
        ),
        HelpSectionEntity(
          section: "contact_us",
          content: ContentEntity(en: "contact_us", ar: "contact_us"),
          contactContent: [
            ContactContentEntity(
              details: ContentEntity(ar: "question", en: "question"),
              method: ContentEntity(ar: "question", en: "question"),
            ),
          ],
        ),
        HelpSectionEntity(
          section: "page_subtitle",
          content: ContentEntity(
            en: "How can we help you today?",
            ar: "كيف يمكننا مساعدتك اليوم؟",
          ),
        ),
        HelpSectionEntity(
          section: "faq",
          content: ContentEntity(en: "question", ar: "question"),
          faqContent: [
            FaqContentEntity(
              question: ContentEntity(ar: "question", en: "question"),
              answer: ContentEntity(ar: "answer", en: "answer"),
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
              BlocProvider<HelpCubit>.value(value: mockHelpCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const HelpViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying HelpViewBody Widgets on Initial/Loading state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocConsumer<HelpCubit, HelpState>), findsOneWidget);
    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets("Verifying HelpViewBody Widgets on Success state", (
    tester,
  ) async {
    // Arrange
    when(
      mockHelpCubit.state,
    ).thenReturn(HelpState(helpStatus: StateStatus.success(helpData)));
    when(mockHelpCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        HelpState(helpStatus: StateStatus.success(helpData)),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocConsumer<HelpCubit, HelpState>), findsOneWidget);
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(ExpansionTile), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
