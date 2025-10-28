import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscle_group_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscles_group_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/muscles_group_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscles_group_list_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
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
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: const MusclesGroupList(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying MusclesGroupList Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(find.byType(MusclesGroupListShimmer), findsOneWidget);
  });

  testWidgets("Verifying MusclesGroupList Widgets on Success state With data", (
    tester,
  ) async {
    // Arrange
    when(mockHomeCubit.state).thenReturn(
      const HomeState(
        musclesGroupStatus: StateStatus.success([
          MuscleGroupEntity(name: "shoulder", id: "1"),
          MuscleGroupEntity(name: "triceps", id: "2"),
        ]),
      ),
    );
    when(mockHomeCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const HomeState(
          musclesGroupStatus: StateStatus.success([
            MuscleGroupEntity(name: "shoulder", id: "1"),
            MuscleGroupEntity(name: "triceps", id: "2"),
          ]),
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.height == 34,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MuscleGroupItem), findsWidgets);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.width == 8,
      ),
      findsWidgets,
    );
  });

  testWidgets(
    "Verifying MusclesGroupList Widgets on Success state Without data",
    (tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(
        const HomeState(musclesGroupStatus: StateStatus.success([])),
      );
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          const HomeState(musclesGroupStatus: StateStatus.success([])),
        ]),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(
        find.text(AppText.emptyExerciseGroupsMessage.tr()),
        findsOneWidget,
      );
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
