import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingBackButton extends StatelessWidget {
  const OnboardingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    final theme = Theme.of(context);
    return CustomElevatedButton(
      onPressed: () =>
          onboardingCubit.doIntent(intent: const MoveToPreviousPageIntent()),
      buttonTitle: AppText.back,
      width: 63.w,
      backgroundColor: Colors.transparent,
      borderColor: theme.colorScheme.onPrimary,
    );
  }
}
