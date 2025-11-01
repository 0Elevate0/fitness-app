import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';

sealed class WorkOutIntent {
  const WorkOutIntent();
}

final class InitWorkOutIntent extends WorkOutIntent {
  final MuscleWithGroupArgument? groupArgument;

  const InitWorkOutIntent(this.groupArgument);
}

final class ChangeWorkOutMusclesGroupIntent extends WorkOutIntent {
  final MuscleGroupEntity muscleGroup;
  final bool fromSwipe;

  const ChangeWorkOutMusclesGroupIntent({
    required this.fromSwipe,
    required this.muscleGroup,
  });
}
