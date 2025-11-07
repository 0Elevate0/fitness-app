import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_item.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercises_list.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/shimmer/exercise_item_shimmer.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercises_list_test.mocks.dart';

 @GenerateMocks([ExerciseCubit])
void main() {
  late MockExerciseCubit mockExerciseCubit;

  const muscle = MuscleEntity(id: 'm1', name: 'Chest', image: '');
  const exercise1 = ExerciseEntity(
    id: 'e1',
    exercise: 'Push Up',
    primaryEquipment: 'None',
  );
  const exercise2 = ExerciseEntity(
    id: 'e2',
    exercise: 'Bench Press',
    primaryEquipment: 'Barbell',
  );
  setUpAll(() {
    provideDummy<ExerciseState>(const ExerciseState());
  });
  setUp(() {
    mockExerciseCubit = MockExerciseCubit();

     when(mockExerciseCubit.state).thenReturn(const ExerciseState());
    when(mockExerciseCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget makeTestableWidget({
    required ExerciseState state,
    required List<ExerciseEntity> exercises,
  }) {
    when(mockExerciseCubit.state).thenReturn(state);
    when(mockExerciseCubit.stream).thenAnswer((_) => Stream.value(state));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: BlocProvider<ExerciseCubit>.value(
              value: mockExerciseCubit,
              child: ExercisesList(exercises: exercises, muscleData: muscle),
            ),
          ),
        );
      },
    );
  }

  testWidgets('ExercisesList shows shimmer when loading', (tester) async {
    final loadingState = const ExerciseState(
      exerciseStatus: StateStatus.loading(),
    );

    await tester.pumpWidget(
      makeTestableWidget(state: loadingState, exercises: []),
    );

    expect(find.byType(ExerciseItemShimmer), findsNWidgets(6));
  });

  testWidgets('ExercisesList shows exercises when success', (tester) async {
    final successState = const ExerciseState(
      exerciseStatus: StateStatus.success([exercise1, exercise2]),
    );

    await tester.pumpWidget(
      makeTestableWidget(
        state: successState,
        exercises: [exercise1, exercise2],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseItem), findsNWidgets(2));
    expect(find.text('Push Up'), findsOneWidget);
    expect(find.text('Bench Press'), findsOneWidget);
  });

  testWidgets('Tapping play icon triggers cubit intent', (tester) async {
    final successState = const ExerciseState(
      exerciseStatus: StateStatus.success([exercise1]),
    );

    await tester.pumpWidget(
      makeTestableWidget(state: successState, exercises: [exercise1]),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    verify(mockExerciseCubit.doIntent(any)).called(1);
  });
}
