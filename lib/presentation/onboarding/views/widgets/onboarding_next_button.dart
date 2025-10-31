import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) => CustomElevatedButton(
        onPressed: () =>
            onboardingCubit.doIntent(intent: const MoveToNextPageIntent()),
        buttonTitle: state.currentPageIndex == state.onboardingList.length - 1
            ? AppText.doIt
            : AppText.next,
        height: state.currentPageIndex > 0 ? 38.h : 40.h,
        width: state.currentPageIndex > 0 ? 63.w : null,
      ),
    );
  }
}
