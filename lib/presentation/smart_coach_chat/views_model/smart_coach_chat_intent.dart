sealed class SmartCoachChatIntent {
  const SmartCoachChatIntent();
}

final class InitSmartCoachChat extends SmartCoachChatIntent {}

final class SendMessageIntent extends SmartCoachChatIntent {
  final String message;

  const SendMessageIntent({required this.message});
}

final class LoadChatIntent extends SmartCoachChatIntent {
  final int? chatId;
  final String? title;
  const LoadChatIntent({this.chatId, this.title});
}
final class LoadAllChatsIntent extends SmartCoachChatIntent {
  const LoadAllChatsIntent();
}
final class SendImageIntent extends SmartCoachChatIntent {
  final String imagePath;
  const SendImageIntent({required this.imagePath});
}
