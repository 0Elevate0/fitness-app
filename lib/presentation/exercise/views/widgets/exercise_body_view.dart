import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/difficulty_levels_section.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercises_list.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/muscle_header_section.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseBodyView extends StatelessWidget {
  final MuscleEntity muscleData;

  const ExerciseBodyView({super.key, required this.muscleData});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ExerciseCubit>(context);

    return BlocListener<ExerciseCubit, ExerciseState>(
      listenWhen: (previous, current) =>
          current.exerciseStatus.isFailure ||
          current.difficultyLevelsStatus.isFailure,
      listener: (context, state) {
        if (state.exerciseStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.exerciseStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.difficultyLevelsStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.difficultyLevelsStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (BuildContext context, ExerciseState state) {
          return BlurredLayerView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MuscleHeaderSection(muscleData: muscleData),

                BlurredContainer(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: DifficultyLevelsSection(
                    levels: state.difficultyLevelsStatus.data ?? [],
                    selected: state.selectedDifficulty,
                    onSelect: (level) {
                      cubit.doIntent(
                        ChangeExerciseLevelIntent(
                          difficultyLevelId: level,
                          primeMoverMuscle: state.selectedMuscle!,
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  child: RPadding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    child: BlurredContainer(
                      child: ExercisesList(
                        exercises: state.exerciseStatus.data ?? [],
                        muscleData: muscleData,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
