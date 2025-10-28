import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_details.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_view_body.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_view_body_test.mocks.dart';

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
            child: const OnboardingViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OnboardingViewBody Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocListener<OnboardingCubit, OnboardingState>),
      findsWidgets,
    );
    expect(find.byType(BlurredLayerView), findsWidgets);
    expect(
      find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
      findsWidgets,
    );
    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(OnboardingDetails), findsOneWidget);
    expect(find.byType(Visibility), findsWidgets);
    expect(find.byType(PositionedDirectional), findsWidgets);
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.text(AppText.skip.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
