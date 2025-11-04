import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BuildProfileResetPasswordForm extends StatelessWidget {
  const BuildProfileResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileResetPasswordCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      builder: (context, state) {
        return BlurredContainer(
          child: RPadding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: cubit.formKey,
              autovalidateMode: state.autoValidateMode,
              child: Column(
                children: [
                  CustomTextFormField(
                    label: AppText.currentPassword,
                    controller: cubit.currentPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: state.isObscure,
                    hintText: AppText.currentPassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validations.passwordValidation(password: value),
                    prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doIntent(ToggleObscurePasswordIntent());
                      },
                      icon: Icon(
                        state.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.colorScheme.onSecondary,
                        size: 22.r,
                      ),
                    ),
                    enabled: !state.profileResetPasswordState.isLoading,
                  ),
                  const RSizedBox(height: 25),
                  CustomTextFormField(
                    label: AppText.newPassword,
                    controller: cubit.newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: state.isObscure,
                    hintText: AppText.newPassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        Validations.passwordValidation(password: value),
                    prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doIntent(ToggleObscurePasswordIntent());
                      },
                      icon: Icon(
                        state.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.colorScheme.onSecondary,
                        size: 22.r,
                      ),
                    ),
                  ),
                  const RSizedBox(height: 25),
                  CustomTextFormField(
                    label: AppText.confirmPassword,
                    controller: cubit.confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: state.isObscure,
                    hintText: AppText.confirmPassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) => Validations.confirmPasswordValidation(
                      password: cubit.newPasswordController.text,
                      confirmPassword: value,
                    ),
                    prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.doIntent(ToggleObscurePasswordIntent());
                      },
                      icon: Icon(
                        state.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.colorScheme.onSecondary,
                        size: 22.r,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomElevatedButton(
                    onPressed: () {
                      cubit.doIntent(OnProfileResetPasswordIntent());
                    },
                    buttonTitle: AppText.done,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
