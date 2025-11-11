import 'package:fitness_app/domain/entities/exercise/exercise_entity.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_item.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/shimmer/exercise_item_shimmer.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_state.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExercisesList extends StatelessWidget {
  final List<ExerciseEntity> exercises;
  final MuscleEntity muscleData;

  const ExercisesList({
    super.key,
    required this.exercises,
    required this.muscleData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (BuildContext context, ExerciseState state) {
        if (state.exerciseStatus.isLoading) {
          return ListView.separated(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (_, __) => const RSizedBox(height: 12),
            itemBuilder: (context, index) => const ExerciseItemShimmer(),
          );
        }
        return ListView.builder(
          padding: REdgeInsets.symmetric(horizontal: 2, vertical: 5),
          physics: const BouncingScrollPhysics(),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];

            return ExerciseItem(exercise: exercise, muscleData: muscleData);
          },
        );
      },
    );
  }
}
