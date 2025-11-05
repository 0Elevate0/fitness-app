import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_selection_item.dart';
import 'package:fitness_app/presentation/profile/views/widgets/select_language_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'select_language_item_test.mocks.dart';

@GenerateMocks([GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<GlobalCubit>.value(
            value: mockGlobalCubit,
            child: const Scaffold(body: SelectLanguageItem()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SelectLanguageItem Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<GlobalCubit, GlobalState>),
      findsNWidgets(2),
    );
    expect(find.byType(ProfileSelectionItem), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(FittedBox), findsWidgets);
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.textContaining(AppText.selectLanguage.tr()), findsOneWidget);
    expect(find.textContaining(AppText.english.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets(
    "Verifying SelectLanguageItem Widgets on ChangeLanguageIntent state",
    (tester) async {
      // Arrange
      when(
        mockGlobalCubit.state,
      ).thenReturn(const GlobalState(selectedLanguage: Language.arabic));
      when(mockGlobalCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          const GlobalState(selectedLanguage: Language.arabic),
        ]),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(
        find.byType(BlocBuilder<GlobalCubit, GlobalState>),
        findsNWidgets(2),
      );
      expect(find.byType(ProfileSelectionItem), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(FittedBox), findsWidgets);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.textContaining(AppText.selectLanguage.tr()), findsOneWidget);
      expect(find.textContaining(AppText.arabic.tr()), findsOneWidget);
      expect(find.byType(RSizedBox), findsWidgets);
      expect(find.byType(Switch), findsOneWidget);
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
