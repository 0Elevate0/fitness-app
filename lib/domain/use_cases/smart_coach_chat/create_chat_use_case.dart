import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateChatUseCase {
  final SmartCoachChatRepository _smartCoachChatRepository;

  const CreateChatUseCase(this._smartCoachChatRepository);

  Future<int> call({String? title}) async {
    return await _smartCoachChatRepository.createChat(title);
  }
}
