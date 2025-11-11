import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditActivityChoices extends StatelessWidget {
  const EditActivityChoices({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) => RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16.r,
          children: FitnessMethodHelper.activityLevels
              .map(
                (activity) => GoalActivityField(
                  title: activity,
                  isSelected:
                      FitnessMethodHelper.getCurrentActivityLevelTitle(
                        activityLevel: state.selectedActivityLevel ?? "",
                      ) ==
                      activity,
                  onSelected: () => editProfileCubit.doIntent(
                    intent: EditActivityIntent(activity: activity),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
