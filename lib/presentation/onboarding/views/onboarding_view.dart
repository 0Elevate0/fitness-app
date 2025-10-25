import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.onboardingbackground,),
            fit:BoxFit.cover ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: OnboardingViewBody(),

      )
    );
  }
}
