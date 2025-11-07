import 'package:fitness_app/data/ai/gemini_service.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/create_chat_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_all_chats_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/insert_message_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_messages_by_chat_use_case.dart';

import 'smart_coach_chat_cubit_test.mocks.dart';

@GenerateMocks([
  GeminiService,
  CreateChatUseCase,
  GetAllChatsUseCase,
  InsertMessageUseCase,
  GetMessagesByChatUseCase,
])
void main() {
  late SmartCoachChatCubit cubit;
  late MockGeminiService mockGeminiService;
  late MockCreateChatUseCase mockCreateChat;
  late MockGetAllChatsUseCase mockGetAllChats;
  late MockInsertMessageUseCase mockInsertMessage;
  late MockGetMessagesByChatUseCase mockGetMessages;

  setUp(() {
    mockGeminiService = MockGeminiService();
    mockCreateChat = MockCreateChatUseCase();
    mockGetAllChats = MockGetAllChatsUseCase();
    mockInsertMessage = MockInsertMessageUseCase();
    mockGetMessages = MockGetMessagesByChatUseCase();

    cubit = SmartCoachChatCubit(
      mockGeminiService,
      mockCreateChat,
      mockGetAllChats,
      mockInsertMessage,
      mockGetMessages,
    );
  });

  test('initial state is correct', () {
    expect(cubit.state, const SmartCoachChatState());
  });

  test('sending a message updates state correctly', () async {
    const chatId = 1;
    const message = "Hello";
    const reply = "Hi there!";

    when(
      mockCreateChat.call(title: anyNamed('title')),
    ).thenAnswer((_) async => chatId);

    when(
      mockInsertMessage.call(chatId: chatId, role: 'user', content: message),
    ).thenAnswer((_) async => 1);

    when(mockGeminiService.sendMessage(message)).thenAnswer((_) async => reply);

    when(
      mockInsertMessage.call(chatId: chatId, role: 'assistant', content: reply),
    ).thenAnswer((_) async => 2);

    await cubit.doIntent(const SendMessageIntent(message: message));

    final messages = cubit.state.messages;
    expect(messages.length, 2);
    expect(messages[0].message, message);
    expect(messages[0].isUser, true);
    expect(messages[1].message, reply);
    expect(messages[1].isUser, false);
  });

  test('loading all chats emits loading and success states', () async {
    final fakeChats = [
      {'id': 1, 'title': 'Chat 1', 'createdAt': '2025-11-07T00:00:00Z'},
    ];

    when(mockGetAllChats.call()).thenAnswer((_) async => fakeChats);

    await cubit.doIntent(const LoadAllChatsIntent());

    expect(cubit.state.loadChatsStatus.isSuccess, true);
    expect(cubit.state.allChats, fakeChats);
  });

  test('sending image updates state correctly', () async {
    const imagePath = 'path/to/image.png';
    when(
      mockCreateChat.call(title: anyNamed('title')),
    ).thenAnswer((_) async => 1);
    when(
      mockInsertMessage.call(chatId: 1, role: 'user', content: imagePath),
    ).thenAnswer((_) async => 1);

    await cubit.doIntent(const SendImageIntent(imagePath: imagePath));

    final messages = cubit.state.messages;
    expect(messages.length, 1);
    expect(messages[0].message, imagePath);
    expect(messages[0].isUser, true);
  });
}
