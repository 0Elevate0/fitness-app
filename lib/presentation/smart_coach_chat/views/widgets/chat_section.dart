import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_bot_loading.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatSection({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartCoachChatCubit, SmartCoachChatState>(
      builder: (context, state) => ListView.separated(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (_, index) {
          if (index < messages.length) {
            return messages[index];
          } else {
            return const ChatBotLoading();
          }
        },
        itemCount: state.sendMessageStatus.isLoading
            ? messages.length + 1
            : messages.length,
        separatorBuilder: (_, __) => const RSizedBox(height: 24),
      ),
    );
  }
}
