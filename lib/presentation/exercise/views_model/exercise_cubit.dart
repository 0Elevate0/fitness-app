import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/use_cases/difficult_levels_by_prime_mover/difficult_levels_use_case.dart';
import 'package:fitness_app/domain/use_cases/exercises_by_muscle_And_difficulty/exercise_use_case.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseUseCase _exerciseUseCase;
  final DifficultLevelsUseCase _difficultLevelsUseCase;

  ExerciseCubit(this._exerciseUseCase, this._difficultLevelsUseCase)
      : super(const ExerciseState());

  void doIntent(ExerciseIntent intent) {
    switch (intent) {
      case ExerciseInitIntent():
        _onInit(intent.muscle);
        break;
      case ChangeExerciseLevelIntent():
        _onChangeExerciseLevel(
          intent.difficultyLevelId,
          intent.primeMoverMuscle,
        );
        break;

      case PlayVideoIntent():
        _onPlayVideo(intent.exercise);
        break;
      case StopVideoIntent():
        _onStopVideo();
        break;
    }
  }

  void _onPlayVideo(ExerciseEntity exercise) {
    final url = exercise.shortYoutubeDemonstrationLink ;
    if (url == null || url.isEmpty) return;

    final videoId = YoutubePlayer.convertUrlToId(url);
     if (videoId == null) return;

    emit(state.copyWith(
      currentExercise: exercise,
      selectedVideoId: videoId,
      isPlayingVideo: true,

    ));
   }

  void _onStopVideo() {
    emit(state.copyWith(
       selectedVideoId: null,
      isPlayingVideo: false,
      currentExercise: null,
    ));
  }
  Future<void> _onInit(MuscleEntity muscle) async {
    emit(
      state.copyWith(
        selectedMuscle: muscle,
        exerciseStatus: const StateStatus.loading(),
        difficultyLevelsStatus: const StateStatus.loading(),
      ),
    );
    final res = await _difficultLevelsUseCase.call(
      primeMoverMuscleId: muscle.id ?? "",
    );
    switch (res) {
      case Success<List<DifficultyLevelEntity>>():
        emit(
          state.copyWith(difficultyLevelsStatus: StateStatus.success(res.data)),
        );
        if (res.data.isNotEmpty) {
          final firstLevel = res.data.first;
          await _onChangeExerciseLevel(firstLevel, muscle);
        }
        break;

      case Failure<List<DifficultyLevelEntity>>():
        emit(
          state.copyWith(
            difficultyLevelsStatus: StateStatus.failure(res.responseException),
          ),
        );
        break;
    }
  }

  Future<void> _onChangeExerciseLevel(DifficultyLevelEntity difficulty,
      MuscleEntity muscle,) async {
    emit(
      state.copyWith(
        selectedMuscle: muscle,
        selectedDifficulty: difficulty,
        exerciseStatus: const StateStatus.loading(),
      ),
    );
    final result = await _exerciseUseCase.call(
      primeMoverMuscleId: muscle.id ?? "",
      difficultyLevelId: difficulty.id ?? "67c797e226895f87ce0aa94b",
    );
    switch (result) {
      case Success<List<ExerciseEntity>>():
        emit(state.copyWith(exerciseStatus: StateStatus.success(result.data)));
      case Failure<List<ExerciseEntity>>():
        emit(
          state.copyWith(
            exerciseStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
