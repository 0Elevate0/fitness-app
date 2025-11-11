import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/muscle_group_item.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'muscle_group_item_test.mocks.dart';

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
  Widget prepareWidget({bool isSelected = false}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: MuscleGroupItem(
              muscleGroupData: const MuscleGroupEntity(id: "id", name: "name"),
              isSelected: isSelected,
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying MuscleGroupItem Widgets with isSelected == false", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedContainer &&
            widget.decoration ==
                BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: null,
                  boxShadow: null,
                ),
      ),
      findsWidgets,
    );
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets("Verifying MuscleGroupItem Widgets with isSelected == true", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget(isSelected: true));
    await tester.pump();
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) => widget is AnimatedContainer),
      findsWidgets,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.style?.color == AppColors.white,
      ),
      findsOneWidget,
    );
  });

  tearDown(() {
    getIt.reset();
  });
}
