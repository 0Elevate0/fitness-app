import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';
import 'package:fitness_app/domain/use_cases/muscles_by_muscle_group/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/domain/use_cases/muscles_group/get_all_muscles_group_use_case.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_intent.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkOutCubit extends Cubit<WorkOutState> {
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetAllMusclesByMuscleGroupUseCase _getAllMusclesByMuscleGroupUseCase;
  PageController? pageController;

  WorkOutCubit(
    this._getAllMusclesGroupUseCase,
    this._getAllMusclesByMuscleGroupUseCase,
  ) : super(const WorkOutState());

  Future<void> doIntent({required WorkOutIntent intent}) async {
    switch (intent) {
      case ChangeWorkOutMusclesGroupIntent():
        await _selectMuscleGroup(muscleGroup: intent.muscleGroup);
        break;
      case InitWorkOutIntent():
        await _onInit(intent.groupArgument);
        break;
    }
  }

  Future<void> _onInit(MuscleWithGroupArgument? group) async {
    if (group == null) {
      await _fetchAllMusclesGroup();
      await _selectMuscleGroup();
      emit(
        state.copyWith(
          groupArgument: MuscleWithGroupArgument(
            muscle: state.musclesByGroupStatus.data,
            muscleGroup: state.musclesGroupStatus.data,
            selectedMuscleGroup: state.selectedMuscleGroup,
          ),
        ),
      );
      return;
    }
    final initialIndex =
        group.muscleGroup?.indexWhere(
          (c) => c.id == group.selectedMuscleGroup?.id,
        ) ??
        0;

    pageController = PageController(
      initialPage: initialIndex.isNegative ? 0 : initialIndex,
    );
    emit(
      state.copyWith(
        groupArgument: group,
        musclesByGroupStatus: StateStatus.success(group.muscle!),
        musclesGroupStatus: StateStatus.success(group.muscleGroup!),
        tabIndex: initialIndex.isNegative ? 0 : initialIndex,
      ),
    );
  }

  Future<void> _fetchAllMusclesGroup() async {
    emit(state.copyWith(musclesGroupStatus: const StateStatus.loading()));
    final result = await _getAllMusclesGroupUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupStatus: StateStatus.success(result.data),
            selectedMuscleGroup: result.data.first,
          ),
        );
        break;
      case Failure<List<MuscleGroupEntity>>():
        emit(
          state.copyWith(
            musclesGroupStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(musclesGroupStatus: const StateStatus.initial()));
    }
  }

  Future<void> _selectMuscleGroup({
    MuscleGroupEntity? muscleGroup,
    bool fromSwipe = false,
  }) async {
    if (muscleGroup?.id != state.selectedMuscleGroup?.id ||
        muscleGroup == null) {
      final newIndex =
          state.groupArgument?.muscleGroup?.indexWhere(
            (c) => c.id == muscleGroup?.id,
          ) ??
          0;
      if (!fromSwipe) {
        pageController?.animateToPage(
          newIndex.isNegative ? 0 : newIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      emit(
        state.copyWith(
          selectedMuscleGroup: muscleGroup ?? state.selectedMuscleGroup,
          musclesByGroupStatus: const StateStatus.loading(),
          tabIndex: newIndex.isNegative ? 0 : newIndex,
        ),
      );

      final result = await _getAllMusclesByMuscleGroupUseCase.invoke(
        muscleGroupId:
            muscleGroup?.id ??
            (state.musclesGroupStatus.data?[0].id ??
                "67c79f3526895f87ce0aa96e"),
      );

      if (isClosed) return;
      switch (result) {
        case Success<List<MuscleEntity>>():
          emit(
            state.copyWith(
              musclesByGroupStatus: StateStatus.success(result.data),
              groupArgument: state.groupArgument?.copyWith(
                muscle: result.data,
                selectedMuscleGroup: muscleGroup ?? state.selectedMuscleGroup,
              ),
            ),
          );
          break;
        case Failure<List<MuscleEntity>>():
          emit(
            state.copyWith(
              musclesByGroupStatus: StateStatus.failure(
                result.responseException,
              ),
            ),
          );
          emit(
            state.copyWith(musclesByGroupStatus: const StateStatus.initial()),
          );
      }
    }
  }

  @override
  Future<void> close() {
    pageController?.dispose();
    return super.close();
  }
}
