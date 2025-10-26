import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/splash/views/splash_view.dart';
import 'package:fitness_app/presentation/splash/views/widgets/splash_view_body.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_intent.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_view_test.mocks.dart';

@GenerateMocks([SplashCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSplashCubit mockSplashCubit;
  setUp(() {
    mockSplashCubit = MockSplashCubit();
    getIt.registerFactory<SplashCubit>(() => mockSplashCubit);
    provideDummy<SplashState>(const SplashState());
    when(mockSplashCubit.state).thenReturn(const SplashState());
    when(
      mockSplashCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const SplashState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<SplashCubit>.value(
            value: mockSplashCubit..doIntent(intent: const GetUserDataIntent()),
            child: const SplashView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SplashView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<SplashCubit>), findsWidgets);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SplashViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
