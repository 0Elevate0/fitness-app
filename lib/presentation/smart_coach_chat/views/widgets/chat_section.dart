import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatSection({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: REdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) => messages[index],
      itemCount: messages.length,
    );
  }
}
