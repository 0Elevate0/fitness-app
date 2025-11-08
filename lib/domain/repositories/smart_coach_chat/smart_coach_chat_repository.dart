abstract interface class SmartCoachChatRepository{
  Future<int> createChat(String? title);

  Future<List<Map<String, dynamic>>> getAllChats();

  Future<int> insertMessage({
    required int chatId,
    required String role,
    required String content,
  });

  Future<List<Map<String, dynamic>>> getMessagesByChat(int chatId);
}