import 'package:fitness_app/data/repositories/smart_coach_chat/smart_coach_chat_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/data/data_source/smart_coach_chat/local_data_source/smart_coach_chat_local_data_source.dart';

import 'smart_coach_chat_repository_impl_test.mocks.dart';

@GenerateMocks([SmartCoachChatLocalDataSource])

void main() {
  late MockSmartCoachChatLocalDataSource mockLocalDataSource;
  late SmartCoachChatRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockSmartCoachChatLocalDataSource();
    repository = SmartCoachChatRepositoryImpl(mockLocalDataSource);
  });

  group('SmartCoachChatRepositoryImpl', () {
    test('createChat calls localDataSource.createChat', () async {
      when(mockLocalDataSource.createChat('Test Chat'))
          .thenAnswer((_) async => 1);

      final result = await repository.createChat('Test Chat');

      expect(result, 1);
      verify(mockLocalDataSource.createChat('Test Chat')).called(1);
    });

    test('getAllChats calls localDataSource.getAllChats', () async {
      when(mockLocalDataSource.getAllChats())
          .thenAnswer((_) async => [{'id': 1, 'title': 'Test'}]);

      final result = await repository.getAllChats();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 1);
      verify(mockLocalDataSource.getAllChats()).called(1);
    });

    test('getMessagesByChat calls localDataSource.getMessagesByChat', () async {
      when(mockLocalDataSource.getMessagesByChat(1))
          .thenAnswer((_) async => [{'id': 1, 'chatId': 1, 'content': 'Hi'}]);

      final result = await repository.getMessagesByChat(1);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.first['chatId'], 1);
      verify(mockLocalDataSource.getMessagesByChat(1)).called(1);
    });

    test('insertMessage calls localDataSource.insertMessage', () async {
      when(mockLocalDataSource.insertMessage(
          chatId: 1, role: 'user', content: 'Hello'))
          .thenAnswer((_) async => 1);

      final result = await repository.insertMessage(
          chatId: 1, role: 'user', content: 'Hello');

      expect(result, 1);
      verify(mockLocalDataSource.insertMessage(
          chatId: 1, role: 'user', content: 'Hello'))
          .called(1);
    });
  });
}
