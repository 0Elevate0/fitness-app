import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityChoices extends StatelessWidget {
  const ActivityChoices({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16.r,
          children: FitnessMethodHelper.activityLevels
              .map(
                (activity) => GoalActivityField(
                  title: activity,
                  isSelected: state.selectedActivity == activity,
                  onSelected: () => registerCubit.doIntent(
                    intent: SelectActivityIntent(activity: activity),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
