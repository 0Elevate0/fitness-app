import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';

class SmartCoachChatState extends Equatable {
  final StateStatus<void> sendMessageStatus;
  final StateStatus<void> loadChatsStatus;
  final List<ChatMessage> messages;
  final List<Map<String, dynamic>> allChats;
  final int? currentChatId;

  const SmartCoachChatState({
    this.sendMessageStatus = const StateStatus.initial(),
    this.loadChatsStatus = const StateStatus.initial(),
    this.messages = const [],
    this.allChats = const [],
    this.currentChatId,
  });

  SmartCoachChatState copyWith({
    StateStatus<void>? sendMessageStatus,
    StateStatus<void>? loadChatsStatus,
    List<ChatMessage>? messages,
    List<Map<String, dynamic>>? allChats,
    int? currentChatId,
  }) {
    return SmartCoachChatState(
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      loadChatsStatus: loadChatsStatus ?? this.loadChatsStatus,
      messages: messages ?? this.messages,
      allChats: allChats ?? this.allChats,
      currentChatId: currentChatId ?? this.currentChatId,
    );
  }

  @override
  List<Object?> get props => [
    sendMessageStatus,
    loadChatsStatus,
    messages,
    allChats,
    currentChatId,
  ];
}
