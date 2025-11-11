import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_gym_image.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_gym_image_test.mocks.dart';

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
            child: const OnboardingGymImage(
              onboardingData: OnboardingEntity(
                title: "title",
                subTitle: "subTitle",
                onboardingImage: AppImages.onboarding1,
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OnboardingGymImage Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<OnboardingCubit, OnboardingState>),
      findsOneWidget,
    );
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
