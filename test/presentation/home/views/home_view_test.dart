import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/presentation/home/views/home_view.dart';
import 'package:fitness_app/presentation/home/views/widgets/home_view_body.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks([HomeCubit, FitnessBottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeCubit mockHomeCubit;
  late MockFitnessBottomNavigationCubit mockFitnessBottomNavigationCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    mockFitnessBottomNavigationCubit = MockFitnessBottomNavigationCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
    getIt.registerFactory<FitnessBottomNavigationCubit>(
      () => mockFitnessBottomNavigationCubit,
    );
    provideDummy<FitnessBottomNavigationState>(
      const FitnessBottomNavigationState(),
    );
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
    when(
      mockFitnessBottomNavigationCubit.state,
    ).thenReturn(const FitnessBottomNavigationState());

    when(mockFitnessBottomNavigationCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const FitnessBottomNavigationState()]),
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
              BlocProvider<HomeCubit>.value(
                value: mockHomeCubit
                  ..doIntent(intent: const HomeInitializationIntent()),
              ),

              BlocProvider<FitnessBottomNavigationCubit>.value(
                value: mockFitnessBottomNavigationCubit,
              ),
            ],
            child: const HomeView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying HomeView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<HomeCubit>), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(HomeViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
