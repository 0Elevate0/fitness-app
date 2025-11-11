import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/domain/repositories/smart_coach_chat/smart_coach_chat_repository.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/create_chat_use_case.dart';

import 'create_chat_use_case_test.mocks.dart';

@GenerateMocks([SmartCoachChatRepository])

void main() {
  late MockSmartCoachChatRepository mockRepository;
  late CreateChatUseCase useCase;

  setUp(() {
    mockRepository = MockSmartCoachChatRepository();
    useCase = CreateChatUseCase(mockRepository);
  });

  group('CreateChatUseCase', () {
    test('should call repository.createChat and return chat id', () async {
       when(mockRepository.createChat('Test Chat'))
          .thenAnswer((_) async => 1);

       final result = await useCase.call(title: 'Test Chat');

       expect(result, 1);
      verify(mockRepository.createChat('Test Chat')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should call repository.createChat with null title and return default id', () async {
      when(mockRepository.createChat(null))
          .thenAnswer((_) async => 2);

      final result = await useCase.call(title: null);

      expect(result, 2);
      verify(mockRepository.createChat(null)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
