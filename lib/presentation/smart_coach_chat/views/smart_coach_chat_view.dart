import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/smart_coach_chat_body_view.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmartCoachChatView extends StatelessWidget {
  const SmartCoachChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SmartCoachChatCubit>(
      create: (_) =>
          getIt.get<SmartCoachChatCubit>()..doIntent(InitSmartCoachChat()),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppImages.chatBackground),
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SmartCoachChatBodyView(),
        ),
      ),
    );
  }
}