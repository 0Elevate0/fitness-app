import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_group_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/workouts_section.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workouts_section_test.mocks.dart';

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
              BlocProvider<HomeCubit>.value(value: mockHomeCubit),

              BlocProvider<FitnessBottomNavigationCubit>.value(
                value: mockFitnessBottomNavigationCubit,
              ),
            ],
            child: const WorkoutsSection(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying WorkoutsSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 5 &&
            widget.children.first is Row,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.children.length == 2 &&
            widget.children.first is Expanded,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is FittedBox,
      ),
      findsNWidgets(2),
    );
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.text(AppText.upcomingWorkouts.tr()), findsOneWidget);
    expect(find.text(AppText.seeAll.tr()), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(MusclesGroupList), findsOneWidget);
    expect(find.byType(MusclesList), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
