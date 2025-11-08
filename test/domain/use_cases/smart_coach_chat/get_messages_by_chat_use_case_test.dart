import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_messages_by_chat_use_case.dart';

import 'create_chat_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachChatRepository])

void main() {
  late MockSmartCoachChatRepository mockRepository;
  late GetMessagesByChatUseCase useCase;

  setUp(() {
    mockRepository = MockSmartCoachChatRepository();
    useCase = GetMessagesByChatUseCase(mockRepository);
  });

  group('GetMessagesByChatUseCase', () {
    final chatId = 1;
    final messagesList = [
      {'id': 1, 'chatId': 1, 'role': 'user', 'content': 'Hello', 'createdAt': '2025-11-07T17:00:00Z'},
      {'id': 2, 'chatId': 1, 'role': 'bot', 'content': 'Hi there!', 'createdAt': '2025-11-07T17:01:00Z'},
    ];

    test('should call repository.getMessagesByChat and return list of messages', () async {
      // arrange
      when(mockRepository.getMessagesByChat(chatId))
          .thenAnswer((_) async => messagesList);

      // act
      final result = await useCase.call(chatId);

      // assert
      expect(result, messagesList);
      verify(mockRepository.getMessagesByChat(chatId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
