import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view_body.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fitness_bottom_navigation_view_body_test.mocks.dart';

@GenerateMocks([FitnessBottomNavigationCubit, HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFitnessBottomNavigationCubit mockFitnessBottomNavigationCubit;
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockFitnessBottomNavigationCubit = MockFitnessBottomNavigationCubit();
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<FitnessBottomNavigationCubit>(
      () => mockFitnessBottomNavigationCubit,
    );
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<FitnessBottomNavigationState>(
      const FitnessBottomNavigationState(),
    );
    provideDummy<HomeState>(const HomeState());
    when(
      mockFitnessBottomNavigationCubit.state,
    ).thenReturn(const FitnessBottomNavigationState());
    when(mockFitnessBottomNavigationCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const FitnessBottomNavigationState()]),
    );
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<FitnessBottomNavigationCubit>.value(
            value: mockFitnessBottomNavigationCubit,
            child: const FitnessBottomNavigationViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FitnessBottomNavigationViewBody Widgets", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(
        BlocBuilder<FitnessBottomNavigationCubit, FitnessBottomNavigationState>,
      ),
      findsOneWidget,
    );
  });

  tearDown(() {
    getIt.reset();
  });
}
