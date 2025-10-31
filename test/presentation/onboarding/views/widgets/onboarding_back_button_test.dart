import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_back_button.dart';
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

import 'onboarding_back_button_test.mocks.dart';

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
            child: const OnboardingBackButton(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OnboardingBackButton Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(AppText.back.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
