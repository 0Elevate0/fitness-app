import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/fitness_bottom_navigation_view.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_bar.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view_body.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fitness_bottom_navigation_view_test.mocks.dart';

@GenerateMocks([FitnessBottomNavigationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFitnessBottomNavigationCubit mockFitnessBottomNavigationCubit;
  setUp(() {
    mockFitnessBottomNavigationCubit = MockFitnessBottomNavigationCubit();
    getIt.registerFactory<FitnessBottomNavigationCubit>(
      () => mockFitnessBottomNavigationCubit,
    );
    provideDummy<FitnessBottomNavigationState>(
      const FitnessBottomNavigationState(),
    );
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
          home: BlocProvider<FitnessBottomNavigationCubit>.value(
            value: mockFitnessBottomNavigationCubit,
            child: const FitnessBottomNavigationView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FitnessBottomNavigationView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocProvider<FitnessBottomNavigationCubit>),
      findsWidgets,
    );
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(FitnessBottomNavigationBar), findsOneWidget);
    expect(find.byType(FitnessBottomNavigationViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
