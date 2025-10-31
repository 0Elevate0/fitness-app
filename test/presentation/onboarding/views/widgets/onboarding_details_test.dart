import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_back_button.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_details.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_next_button.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_details_test.mocks.dart';

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
            child: const Stack(
              children: [
                OnboardingDetails(
                  onboardingData: OnboardingEntity(
                    title: "title",
                    subTitle: "subTitle",
                    onboardingImage: AppImages.onboarding1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OnboardingDetails Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(PositionedDirectional), findsOneWidget);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(
      find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
      findsWidgets,
    );
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(AnimatedSwitcher), findsNWidgets(2));
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsNWidgets(3));
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(Visibility), findsNWidgets(2));
    expect(find.byType(OnboardingNextButton), findsOneWidget);
  });

  testWidgets("Verifying OnboardingDetails Widgets on MovingTONextPage state", (
    tester,
  ) async {
    // Arrange
    when(
      mockOnboardingCubit.state,
    ).thenReturn(const OnboardingState(currentPageIndex: 1));
    when(mockOnboardingCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const OnboardingState(currentPageIndex: 1)]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(PositionedDirectional), findsOneWidget);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(
      find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
      findsWidgets,
    );
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(AnimatedSwitcher), findsNWidgets(2));
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsNWidgets(3));
    expect(find.byType(SmoothPageIndicator), findsOneWidget);
    expect(find.byType(Visibility), findsNWidgets(2));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(OnboardingBackButton), findsOneWidget);
    expect(find.byType(OnboardingNextButton), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
