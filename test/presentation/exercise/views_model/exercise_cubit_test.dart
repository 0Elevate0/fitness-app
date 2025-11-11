import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/use_cases/difficult_levels_by_prime_mover/difficult_levels_use_case.dart';
import 'package:fitness_app/domain/use_cases/exercises_by_muscle_And_difficulty/exercise_use_case.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exercise_cubit_test.mocks.dart';

@GenerateMocks([ExerciseUseCase, DifficultLevelsUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExerciseUseCase mockExerciseUseCase;
  late MockDifficultLevelsUseCase mockDifficultLevelsUseCase;
  late ExerciseCubit cubit;
  late Result<List<ExerciseEntity>> expectedExerciseSuccess;
  late Result<List<DifficultyLevelEntity>> expectedDifficultySuccess;
  late Failure<List<DifficultyLevelEntity>> expectedDifficultyFailure;

  late final MuscleEntity expectedMuscle;
  late final DifficultyLevelEntity expectedDifficulty;
  late final ExerciseArgument expectedArgument;
  late final List<ExerciseEntity> expectedExercises;
  late final List<DifficultyLevelEntity> expectedDifficulties;

  setUpAll(() {
    mockExerciseUseCase = MockExerciseUseCase();
    mockDifficultLevelsUseCase = MockDifficultLevelsUseCase();

    expectedMuscle = const MuscleEntity(id: "1", name: "Chest");
    expectedDifficulty = const DifficultyLevelEntity(id: "2", name: "Intermediate");
    expectedArgument = ExerciseArgument(
      muscle: expectedMuscle,
      difficultyLevel: expectedDifficulty,
    );
    expectedExercises = [
      const ExerciseEntity(id: "10", exercise: "Push Up", shortYoutubeDemonstrationLink: "https://www.youtube.com/watch?v=IODxDxX7oi4"),
    ];
    expectedDifficulties = [
      const DifficultyLevelEntity(id: "2", name: "Intermediate"),
      const DifficultyLevelEntity(id: "3", name: "Advanced"),
    ];
  });

  setUp(() {
    cubit = ExerciseCubit(mockExerciseUseCase, mockDifficultLevelsUseCase);
  });

  group("ExerciseCubit test", () {
    blocTest<ExerciseCubit, ExerciseState>(
      'emits [Loading, Success] when ExerciseInitIntent succeeds',
      build: () {
        expectedDifficultySuccess = Success<List<DifficultyLevelEntity>>(expectedDifficulties);
        expectedExerciseSuccess = Success<List<ExerciseEntity>>(expectedExercises);

        provideDummy<Result<List<DifficultyLevelEntity>>>(expectedDifficultySuccess);
        provideDummy<Result<List<ExerciseEntity>>>(expectedExerciseSuccess);

        when(mockDifficultLevelsUseCase.call(primeMoverMuscleId: anyNamed("primeMoverMuscleId")))
            .thenAnswer((_) async => expectedDifficultySuccess);

        when(mockExerciseUseCase.call(
          primeMoverMuscleId: anyNamed("primeMoverMuscleId"),
          difficultyLevelId: anyNamed("difficultyLevelId"),
        )).thenAnswer((_) async => expectedExerciseSuccess);

        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(ExerciseInitIntent(exerciseArgument: expectedArgument)),
      expect: () => [
        isA<ExerciseState>().having(
              (s) => s.exerciseStatus.isLoading,
          "Is loading exercises",
          equals(true),
        ),
        isA<ExerciseState>()
            .having(
              (s) => s.difficultyLevelsStatus.isSuccess,
          "Difficulty levels loaded successfully",
          equals(true),
        )
            .having(
              (s) => s.selectedDifficulty,
          "Has selected difficulty",
          equals(expectedDifficulty),
        ),
        isA<ExerciseState>()
            .having(
              (s) => s.exerciseStatus.isSuccess,
          "Exercises loaded successfully",
          equals(true),
        )
            .having(
              (s) => s.exerciseStatus.data,
          "Contains expected exercises",
          equals(expectedExercises),
        ),
      ],
      verify: (_) {
        verify(mockDifficultLevelsUseCase.call(primeMoverMuscleId: anyNamed("primeMoverMuscleId"))).called(1);
        verify(mockExerciseUseCase.call(
          primeMoverMuscleId: anyNamed("primeMoverMuscleId"),
          difficultyLevelId: anyNamed("difficultyLevelId"),
        )).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits [Loading, Failure] when ExerciseInitIntent fails',
      build: () {
        expectedDifficultyFailure = Failure(
          responseException: const ResponseException(message: "Failed to load difficulties"),
        );

        provideDummy<Result<List<DifficultyLevelEntity>>>(expectedDifficultyFailure);

        when(mockDifficultLevelsUseCase.call(primeMoverMuscleId: anyNamed("primeMoverMuscleId")))
            .thenAnswer((_) async => expectedDifficultyFailure);

        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(ExerciseInitIntent(exerciseArgument: expectedArgument)),
      expect: () => [
        isA<ExerciseState>().having(
              (s) => s.difficultyLevelsStatus.isLoading,
          "Is loading difficulties",
          equals(true),
        ),
        isA<ExerciseState>()
            .having(
              (s) => s.difficultyLevelsStatus.isFailure,
          "Failed to load difficulties",
          equals(true),
        )
            .having(
              (s) => s.difficultyLevelsStatus.error?.message,
          "Contains failure message",
          equals("Failed to load difficulties"),
        ),
      ],
      verify: (_) {
        verify(mockDifficultLevelsUseCase.call(primeMoverMuscleId: anyNamed("primeMoverMuscleId"))).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits success when ChangeExerciseLevelIntent succeeds',
      build: () {
        expectedExerciseSuccess = Success<List<ExerciseEntity>>(expectedExercises);
        provideDummy<Result<List<ExerciseEntity>>>(expectedExerciseSuccess);
        when(mockExerciseUseCase.call(
          primeMoverMuscleId: anyNamed("primeMoverMuscleId"),
          difficultyLevelId: anyNamed("difficultyLevelId"),
        )).thenAnswer((_) async => expectedExerciseSuccess);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        ChangeExerciseLevelIntent(
          difficultyLevelId: expectedDifficulty,
          primeMoverMuscle: expectedMuscle,
        ),
      ),
      expect: () => [
        isA<ExerciseState>().having((s) => s.exerciseStatus.isLoading, "Is loading", equals(true)),
        isA<ExerciseState>()
            .having((s) => s.exerciseStatus.isSuccess, "Loaded successfully", equals(true))
            .having((s) => s.exerciseStatus.data, "Has data", equals(expectedExercises)),
      ],
      verify: (_) {
        verify(mockExerciseUseCase.call(
          primeMoverMuscleId: anyNamed("primeMoverMuscleId"),
          difficultyLevelId: anyNamed("difficultyLevelId"),
        )).called(1);
      },
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits isPlayingVideo true when PlayVideoIntent called',
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        PlayVideoIntent(
          exercise: expectedExercises.first,
        ),
      ),
      expect: () => [
        isA<ExerciseState>().having(
              (s) => s.isPlayingVideo,
          "Video is playing",
          equals(true),
        ),
      ],
    );

    blocTest<ExerciseCubit, ExerciseState>(
      'emits isPlayingVideo false when StopVideoIntent called',
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(const StopVideoIntent()),
      expect: () => [
        isA<ExerciseState>().having(
              (s) => s.isPlayingVideo,
          "Video stopped",
          equals(false),
        ),
      ],
    );
  });
}
