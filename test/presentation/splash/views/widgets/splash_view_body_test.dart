import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/splash/views/widgets/splash_view_body.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_intent.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_view_body_test.mocks.dart';

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
            child: const SplashViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SplashViewBody Widgets at Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocListener<SplashCubit, SplashState>), findsWidgets);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(BlocBuilder<SplashCubit, SplashState>), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets("Verifying SplashViewBody Widgets at Failure state", (
    tester,
  ) async {
    // Arrange
    when(mockSplashCubit.state).thenReturn(
      const SplashState(
        userDataStatus: StateStatus.failure(
          ResponseException(message: "Failed to login"),
        ),
      ),
    );
    when(mockSplashCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const SplashState(
          userDataStatus: StateStatus.failure(
            ResponseException(message: "Failed to login"),
          ),
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocListener<SplashCubit, SplashState>), findsWidgets);
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Center), findsOneWidget);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(BlocBuilder<SplashCubit, SplashState>), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsNWidgets(2));
    expect(find.text(AppText.tryAgain), findsOneWidget);
    expect(find.text(AppText.reLogin), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
