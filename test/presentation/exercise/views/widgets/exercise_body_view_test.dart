import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/difficulty_levels_section.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_body_view.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercises_list.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/muscle_header_section.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_body_view_test.mocks.dart';

@GenerateMocks([ExerciseCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExerciseCubit mockExerciseCubit;
  late MockGlobalCubit mockGlobalCubit;

  const muscle = MuscleEntity(id: "m1", name: "Chest");

  setUp(() {
    mockExerciseCubit = MockExerciseCubit();
    getIt.registerFactory<ExerciseCubit>(() => mockExerciseCubit);
    provideDummy<ExerciseState>(const ExerciseState());

    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<GlobalState>(const GlobalState());
  });

  tearDown(() {
    getIt.reset();
  });

  Widget prepareWidget({required ExerciseState state}) {
    when(mockExerciseCubit.state).thenReturn(state);
    when(mockExerciseCubit.stream).thenAnswer((_) => Stream.value(state));
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(mockGlobalCubit.stream).thenAnswer((_) => Stream.value(const GlobalState()));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<ExerciseCubit>.value(value: mockExerciseCubit),
                BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
              ],
              child: const ExerciseBodyView(muscleData: muscle),
            ),
          ),
        );
      },
    );
  }


  testWidgets("ExerciseBodyView Widgets on Success state", (tester) async {
    final successState = const ExerciseState(
      difficultyLevelsStatus: StateStatus.success([
        DifficultyLevelEntity(id: "1", name: "Beginner"),
        DifficultyLevelEntity(id: "2", name: "Advanced"),
      ]),
      exerciseStatus: StateStatus.success([
        ExerciseEntity(id: "e1", exercise: "Push Up"),
        ExerciseEntity(id: "e2", exercise: "Bench Press"),
      ]),
      selectedMuscle: muscle,
      selectedDifficulty: DifficultyLevelEntity(id: "1", name: "Beginner"),
    );

    await tester.pumpWidget(prepareWidget(state: successState));

    expect(find.byType(BlocListener<ExerciseCubit, ExerciseState>), findsWidgets);
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(BlocBuilder<ExerciseCubit, ExerciseState>), findsWidgets);
    expect(find.byType(MuscleHeaderSection), findsOneWidget);
    expect(find.byType(DifficultyLevelsSection), findsOneWidget);
    expect(find.byType(ExercisesList), findsOneWidget);
    expect(find.byType(BlurredContainer), findsWidgets);
  });

  testWidgets("ExerciseBodyView Widgets on Loading state", (tester) async {
    final loadingState = const ExerciseState(
      difficultyLevelsStatus: StateStatus.loading(),
      exerciseStatus: StateStatus.loading(),
    );

    await tester.pumpWidget(prepareWidget(state: loadingState));

    expect(find.byType(BlocListener<ExerciseCubit, ExerciseState>), findsWidgets);
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(BlocBuilder<ExerciseCubit, ExerciseState>), findsWidgets);
    expect(find.byType(MuscleHeaderSection), findsOneWidget);
  });
}
