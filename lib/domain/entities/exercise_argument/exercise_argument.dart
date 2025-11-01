import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';

final class ExerciseArgument extends Equatable {
  final MuscleEntity muscle;
  final DifficultyLevelEntity? difficultyLevel;

  const ExerciseArgument({required this.muscle, this.difficultyLevel});

  @override
  List<Object?> get props => [muscle, difficultyLevel];
}
