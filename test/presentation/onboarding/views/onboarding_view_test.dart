import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_view_test.mocks.dart';




@GenerateMocks([OnboardingCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnboardingCubit mockOnboardingCubit;
   void setUpmocks() {
    mockOnboardingCubit = MockOnboardingCubit();
   getIt.registerFactory<OnboardingCubit>(() => mockOnboardingCubit);
    provideDummy<OnboardingState>(const OnboardingState());
    when(mockOnboardingCubit.state).thenReturn(const OnboardingState());
    when(mockOnboardingCubit.stream).thenAnswer((_) =>
        Stream.fromIterable([const OnboardingState()]));
    when(mockOnboardingCubit.pageController).thenReturn(PageController());
    // when(mockOnboardingCubit.doIntent(intent: anyNamed('intent'))).thenAnswer((_) async{});
  }
  setUp(setUpmocks);

  Widget prepareWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
            home: BlocProvider(
              create: (context) => mockOnboardingCubit..doIntent(intent:const OnboardingInitializationIntent()),
              child: const OnboardingView(),
            )

        );
      },
    );
  }
  testWidgets("verify onboarding  structure", (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidgetUnderTest());
    await tester.pumpAndSettle();
    expect(find.byType(BlocProvider<OnboardingCubit>), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Container &&
        widget.child is Scaffold)
        , findsOneWidget);

    expect(find.byType(OnboardingView), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
  tearDown((){getIt.reset();});
}