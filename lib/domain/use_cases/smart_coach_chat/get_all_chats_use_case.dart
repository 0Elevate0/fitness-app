import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllChatsUseCase {
  final SmartCoachChatRepository _smartCoachChatRepository;

  const GetAllChatsUseCase(this._smartCoachChatRepository);

  Future<List<Map<String, dynamic>>> call() async {
    return await _smartCoachChatRepository.getAllChats();
  }
}
