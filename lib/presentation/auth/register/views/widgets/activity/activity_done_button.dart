import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityDoneButton extends StatelessWidget {
  const ActivityDoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => CustomElevatedButton(
        onPressed: state.selectedActivity != null
            ? () => registerCubit.doIntent(
                intent: const MoveToRegistrationNextStepIntent(),
              )
            : null,
        buttonTitle: AppText.done,
      ),
    );
  }
}
