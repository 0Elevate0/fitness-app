import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
      CustomElevatedButton(onPressed: () {
        Navigator.pushNamed(context, RouteNames.homepage);
      }, buttonTitle: 'To Home',)
    ]);
  }
}
