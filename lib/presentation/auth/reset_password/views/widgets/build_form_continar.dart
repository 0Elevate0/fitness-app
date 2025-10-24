import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fitness_app/domain/entities/requests/reset_password_request/reset_password_request_entity.dart';

class BuildFormContainer extends StatelessWidget {
  final String email;

  const BuildFormContainer({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ResetPasswordCubit>(context);
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (BuildContext context, state) {
        return BlurredContainer(
          child: RPadding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: cubit.formKey,
              autovalidateMode: cubit.state.autoValidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextFormField(
                    validator: (value) =>
                        Validations.passwordValidation(password: value),
                    controller: cubit.passwordController,
                    label: AppText.password.tr(),
                    prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                    suffixIcon: GestureDetector(
                      onTap: () => cubit.doIntent(TogglePasswordVisibility()),
                      child: SvgPicture.asset(
                        state.isPasswordVisible
                            ? AppIcons.eye
                            : AppIcons.eye,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !state.isPasswordVisible,
                    textInputAction: TextInputAction.next,
                  ),
                  const RSizedBox(height: 25),

                  CustomTextFormField(
                    validator: (value) => Validations.confirmPasswordValidation(
                      confirmPassword: value,
                      password: cubit.passwordController.text,
                    ),
                    controller: cubit.confirmPasswordController,
                    label: AppText.confirmPassword.tr(),
                    prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          cubit.doIntent(ToggleConfirmPasswordVisibility()),
                      child: SvgPicture.asset(
                        state.isConfirmPasswordVisible
                            ? AppIcons.eye
                            : AppIcons.eye,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !state.isConfirmPasswordVisible,
                    textInputAction: TextInputAction.next,
                  ),

                  const RSizedBox(height: 25),

                  CustomElevatedButton(
                    onPressed: () {
                      final isValid =
                          cubit.formKey.currentState?.validate() ?? false;
                      if (!isValid) return;
                      cubit.doIntent(
                        OnDoneClick(
                          request: ResetPasswordRequestEntity(
                            newPassword: cubit.confirmPasswordController.text,
                            email: email,
                          ),
                        ),
                      );
                    },
                    buttonTitle: AppText.done.tr(),
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
