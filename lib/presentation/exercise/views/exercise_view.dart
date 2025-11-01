import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/exercise_argument/exercise_argument.dart';
import 'package:fitness_app/presentation/exercise/views/widgets/exercise_body_view.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_cubit.dart';
import 'package:fitness_app/presentation/exercise/views_model/exercise_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseView extends StatelessWidget {
  final ExerciseArgument exerciseArgument;
  const ExerciseView({super.key, required this.exerciseArgument});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExerciseCubit>(
      create: (_) =>
          getIt.get<ExerciseCubit>()
            ..doIntent(ExerciseInitIntent(exerciseArgument: exerciseArgument)),
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
            body: ExerciseBodyView(muscleData: exerciseArgument.muscle),
          ),
        ),
      ),
    );
  }
}
