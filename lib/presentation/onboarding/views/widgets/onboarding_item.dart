import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingGymImage extends StatelessWidget {
  const OnboardingGymImage({super.key, required this.onboardingData});
  final OnboardingEntity onboardingData;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.asset(
            onboardingData.onboardingImage,
            fit: BoxFit.fitHeight,
            height: 560.h,
            alignment: AlignmentDirectional.center,
          ),
        ],
      ),
    );
  }
}
