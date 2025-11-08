sealed class SmartCoachChatIntent {
  const SmartCoachChatIntent();
}

final class InitSmartCoachChat extends SmartCoachChatIntent {
  const InitSmartCoachChat();
}

final class SendMessageIntent extends SmartCoachChatIntent {
  final String message;

  const SendMessageIntent({required this.message});
}

final class LoadChatIntent extends SmartCoachChatIntent {
  final int? chatId;
  final String? title;
  const LoadChatIntent({this.chatId, this.title});
}
