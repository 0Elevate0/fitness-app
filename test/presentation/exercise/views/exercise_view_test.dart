import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/exercise_view.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_body_view.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_view_test.mocks.dart';

@GenerateMocks([ExerciseCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExerciseCubit mockExerciseCubit;
  late MockGlobalCubit mockGlobalCubit;

  setUp(() {
    mockExerciseCubit = MockExerciseCubit();
    mockGlobalCubit = MockGlobalCubit();

    getIt.registerFactory<ExerciseCubit>(() => mockExerciseCubit);
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<ExerciseState>(const ExerciseState());
    provideDummy<GlobalState>(const GlobalState());

    when(mockExerciseCubit.state).thenReturn(const ExerciseState());
    when(
      mockExerciseCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ExerciseState()]));

    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  Widget prepareWidget() {
    const muscle = MuscleEntity(id: "1", name: "Chest");
    const difficulty = DifficultyLevelEntity(id: "2", name: "Intermediate");
    const argument = ExerciseArgument(
      muscle: muscle,
      difficultyLevel: difficulty,
    );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            BlocProvider<ExerciseCubit>.value(
              value: mockExerciseCubit
                ..doIntent(
                  const ExerciseInitIntent(exerciseArgument: argument),
                ),
            ),
          ],
          child: const MaterialApp(
            home: ExerciseView(exerciseArgument: argument),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ExerciseView Widgets", (tester) async {
    await tester.pumpWidget(prepareWidget());

    expect(find.byType(BlocProvider<ExerciseCubit>), findsAny);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(ExerciseBodyView), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
