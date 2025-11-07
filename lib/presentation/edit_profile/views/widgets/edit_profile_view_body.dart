import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_activity/edit_activity_section.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_goal/edit_goal_section.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_details_section.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_weight/edit_weight_section.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_intent.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.updatePhotoStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.updatePhotoStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.editProfileStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.editProfileStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.updatePhotoStatus.isSuccess) {
          profileCubit.doIntent(
            intent: InitializeUserDataIntent(
              newImagePath: state.newSelectedImg,
            ),
          );
          Loaders.showSuccessMessage(
            message: AppText.profilePhotoSuccessMessage,
            context: context,
          );
        } else if (state.editProfileStatus.isSuccess) {
          profileCubit.doIntent(
            intent: InitializeUserDataIntent(
              newFirstName: state.userData?.firstName,
              newLastName: state.userData?.lastName,
              newWeight: state.selectedWeight,
              newActivityLevel: state.selectedActivityLevel,
              newGoal: state.selectedGoal,
            ),
          );
          Navigator.of(context).pop();
          Loaders.showSuccessMessage(
            message: AppText.editProfileSuccessMessage,
            context: context,
          );
        } else if (state.isNoChanges == true) {
          Navigator.of(context).pop();
        }
      },
      child: BlurredLayerView(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: SafeArea(
            bottom: false,
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) => switch (state.currentSection) {
                EditProfileSection.editProfile =>
                  const EditProfileDetailsSection(),
                EditProfileSection.editWeight => const EditWeightSection(),
                EditProfileSection.editGoal => const EditGoalSection(),
                EditProfileSection.editActivity => const EditActivitySection(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
