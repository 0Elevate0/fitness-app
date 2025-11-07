import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/bracket_text.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileGoalsSection extends StatelessWidget {
  const EditProfileGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) => Column(
        children: [
          const BracketText(
            textOutside: AppText.yourWeight,
            textInside: AppText.tapToEdit,
          ),
          const RSizedBox(height: 8),
          GoalActivityField(
            title: "${state.selectedWeight} ${AppText.kg.tr()}",
            haveCircularSelection: false,
            onSelected: () => editProfileCubit.doIntent(
              intent: const ChangeEditProfileSectionIntent(
                section: EditProfileSection.editWeight,
              ),
            ),
          ),
          const RSizedBox(height: 16),
          const BracketText(
            textOutside: AppText.yourGoal,
            textInside: AppText.tapToEdit,
          ),
          const RSizedBox(height: 8),
          GoalActivityField(
            title: state.selectedGoal ?? AppText.notProvided.tr(),
            haveCircularSelection: false,
            onSelected: () => editProfileCubit.doIntent(
              intent: const ChangeEditProfileSectionIntent(
                section: EditProfileSection.editGoal,
              ),
            ),
          ),
          const RSizedBox(height: 16),
          const BracketText(
            textOutside: AppText.yourActivityLevel,
            textInside: AppText.tapToEdit,
          ),
          const RSizedBox(height: 8),
          GoalActivityField(
            title: FitnessMethodHelper.getCurrentActivityLevelTitle(
              activityLevel:
                  state.selectedActivityLevel ?? AppText.notProvided.tr(),
            ),
            haveCircularSelection: false,
            onSelected: () => editProfileCubit.doIntent(
              intent: const ChangeEditProfileSectionIntent(
                section: EditProfileSection.editActivity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
