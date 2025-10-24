import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/constants/widget_keys.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomElevatedButton(
        key: const Key(WidgetKeys.register),
        onPressed: () => registerCubit.doIntent(
          intent: const MoveToRegistrationNextStepIntent(),
        ),
        buttonTitle: AppText.register,
      ),
    );
  }
}
