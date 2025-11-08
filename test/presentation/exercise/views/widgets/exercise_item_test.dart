import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_item.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_item_test.mocks.dart';

@GenerateMocks([ExerciseCubit])
void main() {
  late MockExerciseCubit mockExerciseCubit;

  const muscle = MuscleEntity(id: 'm1', name: 'Chest', image: '');
  const exercise = ExerciseEntity(
    id: 'e1',
    exercise: 'Push Up',
    primaryEquipment: 'None',
  );
  setUpAll(() {
    provideDummy<ExerciseState>(const ExerciseState());
  });

  setUp(() {
    mockExerciseCubit = MockExerciseCubit();

    when(mockExerciseCubit.state).thenReturn(const ExerciseState());
    when(mockExerciseCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('ExerciseItem displays correctly and responds to tap', (
    tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: BlocProvider<ExerciseCubit>.value(
                value: mockExerciseCubit,
                child: const ExerciseItem(
                  exercise: exercise,
                  muscleData: muscle,
                ),
              ),
            ),
          );
        },
      ),
    );

    expect(find.text('Push Up'), findsOneWidget);
    expect(find.text('None'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    verify(mockExerciseCubit.doIntent(any)).called(1);
  });
}
