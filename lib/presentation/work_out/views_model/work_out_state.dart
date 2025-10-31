import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';

final class WorkOutState extends Equatable {
  final StateStatus<List<MuscleGroupEntity>> musclesGroupStatus;
  final StateStatus<List<MuscleEntity>> musclesByGroupStatus;
  final MuscleGroupEntity? selectedMuscleGroup;
  final MuscleWithGroupArgument? groupArgument;

  const WorkOutState({
    this.musclesGroupStatus = const StateStatus.initial(),
    this.musclesByGroupStatus = const StateStatus.initial(),
    this.selectedMuscleGroup,
    this.groupArgument,
  });

  WorkOutState copyWith({
    StateStatus<List<MuscleGroupEntity>>? musclesGroupStatus,
    StateStatus<List<MuscleEntity>>? musclesByGroupStatus,
    MuscleGroupEntity? selectedMuscleGroup,
    MuscleWithGroupArgument? groupArgument,
  }) {
    return WorkOutState(
      musclesGroupStatus: musclesGroupStatus ?? this.musclesGroupStatus,
      musclesByGroupStatus: musclesByGroupStatus ?? this.musclesByGroupStatus,
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
      groupArgument: groupArgument ?? this.groupArgument,
    );
  }

  @override
  List<Object?> get props => [
    musclesGroupStatus,
    musclesByGroupStatus,
    selectedMuscleGroup,
    groupArgument,
  ];
}
