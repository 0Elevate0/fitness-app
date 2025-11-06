import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertMessageUseCase {
  final SmartCoachChatRepository _smartCoachChatRepository;

  const InsertMessageUseCase(this._smartCoachChatRepository);

  Future<int> call({
    required int chatId,
    required String role,
    required String content,
  }) async {
    return await _smartCoachChatRepository.insertMessage(
      chatId: chatId,
      role: role,
      content: content,
    );
  }
}
