import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/insert_message_use_case.dart';

import 'create_chat_use_case_test.mocks.dart';
@GenerateMocks([SmartCoachChatRepository])

void main() {
  late MockSmartCoachChatRepository mockRepository;
  late InsertMessageUseCase useCase;

  setUp(() {
    mockRepository = MockSmartCoachChatRepository();
    useCase = InsertMessageUseCase(mockRepository);
  });

  group('InsertMessageUseCase', () {
    const chatId = 1;
    const role = 'user';
    const content = 'Hello!';
    const insertedId = 100;

    test('should call repository.insertMessage and return inserted message id', () async {
      // arrange
      when(mockRepository.insertMessage(
        chatId: chatId,
        role: role,
        content: content,
      )).thenAnswer((_) async => insertedId);

      // act
      final result = await useCase.call(chatId: chatId, role: role, content: content);

      // assert
      expect(result, insertedId);
      verify(mockRepository.insertMessage(chatId: chatId, role: role, content: content)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
