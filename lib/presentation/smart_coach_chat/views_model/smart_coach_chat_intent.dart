sealed class SmartCoachChatIntent {
  const SmartCoachChatIntent();
}

final class InitSmartCoachChat extends SmartCoachChatIntent {}

final class SendMessageIntent extends SmartCoachChatIntent {
  final String message;

  const SendMessageIntent({required this.message});
}
