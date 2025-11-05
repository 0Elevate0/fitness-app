import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';

class SmartCoachChatState {
  final StateStatus<void> sendMessageStatus;
  final List<ChatMessage> messages;

  const SmartCoachChatState({
    this.sendMessageStatus = const StateStatus.initial(),
    this.messages = const [],
  });

  SmartCoachChatState copyWith({
    StateStatus<void>? sendMessageStatus,
    List<ChatMessage>? messages,
  }) {
    return SmartCoachChatState(
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      messages: messages ?? this.messages,
    );
  }
}
