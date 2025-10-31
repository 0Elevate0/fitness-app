import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';

final class MuscleWithGroupArgument extends Equatable {
  final List<MuscleGroupEntity>? muscleGroup;
  final List<MuscleEntity>? muscle;
  final MuscleGroupEntity? selectedMuscleGroup;

  const MuscleWithGroupArgument({
    this.muscleGroup,
    this.muscle,
    this.selectedMuscleGroup,
  });

  @override
  List<Object?> get props => [muscleGroup, muscle, selectedMuscleGroup];

  MuscleWithGroupArgument? copyWith({
    List<MuscleEntity>? muscle,
    List<MuscleGroupEntity>? muscleGroup,
    MuscleGroupEntity? selectedMuscleGroup,
  }) {
    return MuscleWithGroupArgument(
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
      muscle: muscle ?? this.muscle,
      muscleGroup: muscleGroup ?? this.muscleGroup,
    );
  }
}
