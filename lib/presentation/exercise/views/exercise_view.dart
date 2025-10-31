import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_body_view.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseView extends StatelessWidget {
  final MuscleEntity muscle;

  const ExerciseView({super.key, required this.muscle,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseCubit>(
      create: (_) =>
          getIt.get<ExerciseCubit>()
            ..doIntent(ExerciseInitIntent(muscle: muscle)),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImages.homeBackground),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ExerciseBodyView(muscleData: muscle,),
          ),
        ),
      ),
    );
  }
}
