import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => Form(
        key: registerCubit.registerFormKey,
        autovalidateMode: state.autoValidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              controller: registerCubit.firstNameController,
              label: AppText.firstName,
              hintText: AppText.firstNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: SvgPicture.asset(AppIcons.user),
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 16),
            CustomTextFormField(
              controller: registerCubit.lastNameController,
              label: AppText.lastName,
              hintText: AppText.lastNameHint,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              prefixIcon: SvgPicture.asset(AppIcons.user),
              validator: (value) => Validations.fieldValidation(value: value),
            ),
            const RSizedBox(height: 16),
            CustomTextFormField(
              controller: registerCubit.emailController,
              label: AppText.email,
              hintText: AppText.emailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: SvgPicture.asset(AppIcons.email),
              validator: (value) => Validations.emailValidation(email: value),
            ),
            const RSizedBox(height: 16),
            CustomTextFormField(
              controller: registerCubit.passwordController,
              label: AppText.password,
              hintText: AppText.passwordHint,
              obscureText: state.isObscure,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              prefixIcon: SvgPicture.asset(AppIcons.passwordLock),
              suffixIcon: GestureDetector(
                onTap: () {
                  registerCubit.doIntent(
                    intent: const ToggleObscurePasswordIntent(),
                  );
                },
                child: Icon(
                  state.isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: theme.colorScheme.shadow,
                  size: 20.sp,
                ),
              ),
              validator: (value) =>
                  Validations.passwordValidation(password: value),
            ),
          ],
        ),
      ),
    );
  }
}
