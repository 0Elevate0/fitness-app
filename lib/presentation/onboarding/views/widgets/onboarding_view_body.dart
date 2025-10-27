import 'package:fitness_app/core/router/route_names.dart';
import 'package:flutter/material.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
        Navigator.pushNamed(context, RouteNames.login);
      }, child: const Text("test")),
    );
  }
}
