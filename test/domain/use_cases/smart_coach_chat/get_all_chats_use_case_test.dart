import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_all_chats_use_case.dart';

import 'create_chat_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachChatRepository])

void main() {
  late MockSmartCoachChatRepository mockRepository;
  late GetAllChatsUseCase useCase;

  setUp(() {
    mockRepository = MockSmartCoachChatRepository();
    useCase = GetAllChatsUseCase(mockRepository);
  });

  group('GetAllChatsUseCase', () {
    final chatList = [
      {'id': 1, 'title': 'Chat 1', 'createdAt': '2025-11-07T17:00:00Z'},
      {'id': 2, 'title': 'Chat 2', 'createdAt': '2025-11-07T18:00:00Z'},
    ];

    test('should call repository.getAllChats and return list of chats', () async {
      // arrange
      when(mockRepository.getAllChats()).thenAnswer((_) async => chatList);

      // act
      final result = await useCase.call();

      // assert
      expect(result, chatList);
      verify(mockRepository.getAllChats()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
