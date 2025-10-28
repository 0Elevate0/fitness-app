import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/use_cases/muscles_by_muscle_group/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_group/get_all_muscles_group_use_case.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_intent.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'work_out_cubit_test.mocks.dart';

@GenerateMocks([GetAllMusclesGroupUseCase, GetAllMusclesByMuscleGroupUseCase])
void main() {
  late MockGetAllMusclesGroupUseCase mockGetAllMusclesGroupUseCase;
  late MockGetAllMusclesByMuscleGroupUseCase
  mockGetAllMusclesByMuscleGroupUseCase;
  late WorkOutCubit cubit;
  provideDummy<Result<List<MuscleGroupEntity>>>(Success(<MuscleGroupEntity>[]));
  provideDummy<Result<List<MuscleEntity>>>(Success(<MuscleEntity>[]));
  final mockMuscleGroups = [
    const MuscleGroupEntity(id: '1', name: 'Chest'),
    const MuscleGroupEntity(id: '2', name: 'Back'),
  ];

  final mockMuscles = [
    const MuscleEntity(id: 'm1', name: 'Push Up'),
    const MuscleEntity(id: 'm2', name: 'Bench Press'),
  ];
  setUp(() {
    mockGetAllMusclesGroupUseCase = MockGetAllMusclesGroupUseCase();
    mockGetAllMusclesByMuscleGroupUseCase =
        MockGetAllMusclesByMuscleGroupUseCase();
    cubit = WorkOutCubit(
      mockGetAllMusclesGroupUseCase,
      mockGetAllMusclesByMuscleGroupUseCase,
    );
    when(
      mockGetAllMusclesGroupUseCase.invoke(),
    ).thenAnswer((_) async => Success(mockMuscleGroups));
    when(
      mockGetAllMusclesByMuscleGroupUseCase.invoke(
        muscleGroupId: anyNamed('muscleGroupId'),
      ),
    ).thenAnswer((_) async => Success(mockMuscles));
  });

  tearDown(() => cubit.close());

  group('WorkOutCubit Tests', () {
    blocTest<WorkOutCubit, WorkOutState>(
      'emits success when fetching muscle groups succeeds',
      build: () {
        when(
          mockGetAllMusclesGroupUseCase.invoke(),
        ).thenAnswer((_) async => Success(mockMuscleGroups));
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const InitWorkOutIntent(null)),
      expect: () => containsAllInOrder([
        // loading
        isA<WorkOutState>().having(
          (s) => s.musclesGroupStatus.isLoading,
          'loading',
          true,
        ),
        // success
        isA<WorkOutState>().having(
          (s) => s.musclesGroupStatus.isSuccess,
          'success',
          true,
        ),
      ]),
    );

    blocTest<WorkOutCubit, WorkOutState>(
      'emits failure when fetching muscle groups fails',
      build: () {
        when(mockGetAllMusclesGroupUseCase.invoke()).thenAnswer(
          (_) async => Failure(
            responseException: const ResponseException(
              message: 'someThing wrong',
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const InitWorkOutIntent(null)),
      expect: () => containsAllInOrder([
        isA<WorkOutState>().having(
          (s) => s.musclesGroupStatus.isLoading,
          'loading',
          true,
        ),
        isA<WorkOutState>().having(
          (s) => s.musclesGroupStatus.isFailure,
          'failure',
          true,
        ),
        isA<WorkOutState>().having(
          (s) => s.musclesGroupStatus.isInitial,
          'reset',
          true,
        ),
      ]),
    );

    blocTest<WorkOutCubit, WorkOutState>(
      'emits success when selecting muscle group succeeds',
      build: () {
        when(
          mockGetAllMusclesByMuscleGroupUseCase.invoke(
            muscleGroupId: anyNamed('muscleGroupId'),
          ),
        ).thenAnswer((_) async => Success(mockMuscles));

        cubit.emit(
          cubit.state.copyWith(
            musclesGroupStatus: StateStatus.success(mockMuscleGroups),
            selectedMuscleGroup: mockMuscleGroups.last,
          ),
        );

        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: ChangeWorkOutMusclesGroupIntent(
          muscleGroup: mockMuscleGroups.first,
        ),
      ),
      expect: () => containsAllInOrder([
        isA<WorkOutState>().having(
          (s) => s.musclesByGroupStatus.isLoading,
          'loading',
          true,
        ),
        isA<WorkOutState>().having(
          (s) => s.musclesByGroupStatus.isSuccess,
          'success',
          true,
        ),
      ]),
    );
  });
}
