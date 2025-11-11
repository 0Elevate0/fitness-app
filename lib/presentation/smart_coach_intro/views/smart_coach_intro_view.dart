import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_body_view.dart';
import 'package:flutter/material.dart';

class SmartCoachIntroView extends StatelessWidget {
  const SmartCoachIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImages.chatBackground),
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: SmartCoachIntroBodyView(),
      ),
    );
  }
}
