import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalChoices extends StatelessWidget {
  const GoalChoices({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16.r,
          children: FitnessMethodHelper.goals
              .map(
                (goal) => GoalActivityField(
                  title: goal,
                  isSelected: state.selectedGoal == goal,
                  onSelected: () => registerCubit.doIntent(
                    intent: SelectGoalIntent(goal: goal),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
