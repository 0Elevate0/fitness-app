import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDoneButton extends StatelessWidget {
  const EditDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    return CustomElevatedButton(
      onPressed: () => editProfileCubit.doIntent(
        intent: const ChangeEditProfileSectionIntent(
          section: EditProfileSection.editProfile,
        ),
      ),
      buttonTitle: AppText.done,
    );
  }
}
