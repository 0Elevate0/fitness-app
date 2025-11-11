import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_avatar.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_form.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_goals_section.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/update_profile_button.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileDetailsSection extends StatelessWidget {
  const EditProfileDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) =>
          current.updatePhotoStatus.isLoading ||
          current.updatePhotoStatus.isFailure ||
          current.updatePhotoStatus.isSuccess ||
          current.editProfileStatus.isLoading ||
          current.editProfileStatus.isFailure,
      builder: (context, state) => AbsorbPointer(
        absorbing:
            state.editProfileStatus.isLoading ||
            state.updatePhotoStatus.isLoading,
        child: RPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RSizedBox(height: 12),
              CustomAppBar(
                padding: EdgeInsets.zero,
                title: AppText.editProfile.tr(),
                titlePadding: REdgeInsetsDirectional.only(end: 24),
                automaticallyImplyLeading: true,
              ),
              const RSizedBox(height: 40),
              const EditProfileAvatar(),
              const RSizedBox(height: 32),
              const EditProfileForm(),
              const RSizedBox(height: 32),
              const EditProfileGoalsSection(),
              const RSizedBox(height: 24),
              const UpdateProfileButton(),
              const RSizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
