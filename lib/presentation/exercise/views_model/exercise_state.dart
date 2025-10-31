import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';

final class ExerciseState extends Equatable {
  final StateStatus<List<ExerciseEntity>> exerciseStatus;
  final StateStatus<List<DifficultyLevelEntity>> difficultyLevelsStatus;
  final MuscleEntity? selectedMuscle;
  final DifficultyLevelEntity? selectedDifficulty;
  final bool isPlayingVideo;
  final ExerciseEntity? currentExercise;
  final String? selectedVideoId;


  const ExerciseState({
    this.exerciseStatus = const StateStatus.initial(),
    this.difficultyLevelsStatus = const StateStatus.initial(),
    this.selectedMuscle,
    this.selectedDifficulty,
    this.isPlayingVideo = false,
    this.currentExercise,
    this.selectedVideoId

  });

  ExerciseState copyWith({
    StateStatus<List<ExerciseEntity>>? exerciseStatus,
    StateStatus<List<DifficultyLevelEntity>>? difficultyLevelsStatus,
    MuscleEntity? selectedMuscle,
    DifficultyLevelEntity? selectedDifficulty,
    bool? isPlayingVideo,
    ExerciseEntity? currentExercise,
    String? selectedVideoId,

  }) {
    return ExerciseState(
      exerciseStatus: exerciseStatus ?? this.exerciseStatus,
      difficultyLevelsStatus:
          difficultyLevelsStatus ?? this.difficultyLevelsStatus,
      selectedMuscle: selectedMuscle ?? this.selectedMuscle,
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
      isPlayingVideo: isPlayingVideo ?? this.isPlayingVideo,
      currentExercise: currentExercise ?? this.currentExercise,
      selectedVideoId: selectedVideoId ?? this.selectedVideoId,
    );
  }

  @override
  List<Object?> get props => [
    isPlayingVideo,
    exerciseStatus,
    difficultyLevelsStatus,
    selectedMuscle,
    selectedDifficulty,
    currentExercise,
    selectedVideoId
  ];
}
