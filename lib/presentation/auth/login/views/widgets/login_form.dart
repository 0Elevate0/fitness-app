import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/forget_password_button.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/have_an_account_and_register_row.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/social_media_section.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => BlurredContainer(
        child: RPadding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: loginCubit.loginFormKey,
            child: Column(
              children: [
                Text(AppText.login.tr(), style: theme.textTheme.headlineLarge),
                RSizedBox(height: 16.h),
                CustomTextFormField(
                  controller: loginCubit.emailController,
                  label: AppText.email,
                  hintText: AppText.emailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.email),
                  validator: (value) =>
                      Validations.emailValidation(email: value),
                  enabled: !state.loginStatus.isLoading,
                  onChanged: (_) => loginCubit.doIntent(
                    intent: CheckFieldsValidationIntent(),
                  ),
                ),
                const RSizedBox(height: 24),
                CustomTextFormField(
                  controller: loginCubit.passwordController,
                  label: AppText.password,
                  hintText: AppText.passwordHint,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      loginCubit.doIntent(
                        intent: ToggleObscurePasswordIntent(),
                      );
                    },
                    icon: Icon(
                      state.isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 22.r,
                    ),
                  ),
                  obscuringCharacter: "*",
                  obscureText: state.isObscure,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) =>
                      Validations.passwordValidation(password: value),
                  enabled: !state.loginStatus.isLoading,
                  onChanged: (_) => loginCubit.doIntent(
                    intent: CheckFieldsValidationIntent(),
                  ),
                ),
                const Row(children: [Spacer(), ForgetPasswordButton()]),
                const RSizedBox(height: 10),
                const SocialMediaSection(),
                const RSizedBox(height: 24),
                CustomElevatedButton(
                  onPressed: () {
                    if (state.isValidToLogin) {
                      loginCubit.doIntent(
                        intent: LoginWithEmailAndPasswordIntent(),
                      );
                    } else {
                      loginCubit.doIntent(intent: EnableValidationIntent());
                    }
                  },
                  buttonTitle: AppText.login.tr(),
                ),
                const HaveAnAccountAndRegisterRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
