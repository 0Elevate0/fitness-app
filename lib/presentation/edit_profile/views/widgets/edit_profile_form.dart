import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) => Form(
        key: editProfileCubit.editProfileKey,
        autovalidateMode: state.autoValidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              controller: editProfileCubit.firstNameController,
              label: AppText.firstName,
              hintText: AppText.firstNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: SvgPicture.asset(AppIcons.user),
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 16),
            CustomTextFormField(
              controller: editProfileCubit.lastNameController,
              label: AppText.lastName,
              hintText: AppText.lastNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              prefixIcon: SvgPicture.asset(AppIcons.user),
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 16),
            CustomTextFormField(
              controller: editProfileCubit.emailController,
              label: AppText.email,
              prefixIcon: SvgPicture.asset(AppIcons.email),
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
