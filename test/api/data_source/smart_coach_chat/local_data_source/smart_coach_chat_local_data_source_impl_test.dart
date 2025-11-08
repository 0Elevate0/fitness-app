import 'package:fitness_app/api/data_source/smart_coach_chat/local_data_source/smart_coach_chat_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/local/database_helper.dart';

import 'smart_coach_chat_local_data_source_impl_test.mocks.dart';

 @GenerateMocks([DatabaseHelper])

void main() {
  late MockDatabaseHelper mockDbHelper;
  late SmartCoachChatLocalDataSourceImpl localDataSource;

  setUp(() {
    mockDbHelper = MockDatabaseHelper();
    localDataSource = SmartCoachChatLocalDataSourceImpl(mockDbHelper);
  });

  group('SmartCoachChatLocalDataSourceImpl', () {
    test('createChat calls DatabaseHelper.createChat', () async {
      when(mockDbHelper.createChat(title: anyNamed('title')))
          .thenAnswer((_) async => 1);

      final result = await localDataSource.createChat('Test Chat');

      expect(result, 1);
      verify(mockDbHelper.createChat(title: 'Test Chat')).called(1);
    });

    test('getAllChats calls DatabaseHelper.getAllChats', () async {
      when(mockDbHelper.getAllChats())
          .thenAnswer((_) async => [{'id': 1, 'title': 'Test'}]);

      final result = await localDataSource.getAllChats();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.length, 1);
      verify(mockDbHelper.getAllChats()).called(1);
    });

    test('getMessagesByChat calls DatabaseHelper.getMessagesByChat', () async {
      when(mockDbHelper.getMessagesByChat(1))
          .thenAnswer((_) async => [{'id': 1, 'chatId': 1, 'content': 'Hi'}]);

      final result = await localDataSource.getMessagesByChat(1);

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.first['chatId'], 1);
      verify(mockDbHelper.getMessagesByChat(1)).called(1);
    });

    test('insertMessage calls DatabaseHelper.insertMessage', () async {
      when(mockDbHelper.insertMessage(1, 'user', 'Hello'))
          .thenAnswer((_) async => 1);

      final result = await localDataSource.insertMessage(
        chatId: 1,
        role: 'user',
        content: 'Hello',
      );

      expect(result, 1);
      verify(mockDbHelper.insertMessage(1, 'user', 'Hello')).called(1);
    });
  });
}
