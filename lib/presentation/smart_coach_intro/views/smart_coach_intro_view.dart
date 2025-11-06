import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmartCoachIntroView extends StatelessWidget {
  const SmartCoachIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SmartCoachChatCubit>(
      create: (_) =>
          getIt.get<SmartCoachChatCubit>(),
      child: Container(
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
      ),
    );
  }
}
