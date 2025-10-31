import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_next_button.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_next_button_test.mocks.dart';

@GenerateMocks([OnboardingCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnboardingCubit mockOnboardingCubit;
  setUp(() {
    mockOnboardingCubit = MockOnboardingCubit();
    final realPageController = PageController(initialPage: 0);
    getIt.registerFactory<OnboardingCubit>(() => mockOnboardingCubit);
    provideDummy<OnboardingState>(const OnboardingState());
    when(mockOnboardingCubit.pageController).thenReturn(realPageController);
    when(mockOnboardingCubit.state).thenReturn(const OnboardingState());
    when(
      mockOnboardingCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const OnboardingState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<OnboardingCubit>.value(
            value: mockOnboardingCubit
              ..doIntent(intent: const OnboardingInitializationIntent()),
            child: const OnboardingNextButton(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OnboardingNextButton Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
      findsOneWidget,
    );
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(AppText.next.tr()), findsOneWidget);
  });

  testWidgets(
    "Verifying OnboardingNextButton Widgets on MoveToNextPageIntent with last page state",
    (tester) async {
      // Arrange
      when(mockOnboardingCubit.state).thenReturn(
        OnboardingState(
          currentPageIndex: mockOnboardingCubit.state.onboardingList.length - 1,
        ),
      );
      when(mockOnboardingCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          OnboardingState(
            currentPageIndex:
                mockOnboardingCubit.state.onboardingList.length - 1,
          ),
        ]),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(
        find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
        findsOneWidget,
      );
      expect(find.byType(CustomElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(AppText.doIt.tr()), findsOneWidget);
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
