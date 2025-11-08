import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesByChatUseCase {
  final SmartCoachChatRepository _smartCoachChatRepository;

  const GetMessagesByChatUseCase(this._smartCoachChatRepository);

  Future<List<Map<String, dynamic>>> call(int chatId) async {
    return await _smartCoachChatRepository.getMessagesByChat(chatId);
  }
}
