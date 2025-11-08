import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/data/ai/gemini_service.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/create_chat_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_all_chats_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/get_messages_by_chat_use_case.dart';
import 'package:fitness_app/domain/use_cases/smart_coach_chat/insert_message_use_case.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SmartCoachChatCubit extends Cubit<SmartCoachChatState> {
  final GeminiService _geminiService;
  final CreateChatUseCase _createChat;
  final GetAllChatsUseCase _getAllChats;
  final InsertMessageUseCase _insertMessage;
  final GetMessagesByChatUseCase _getMessages;
  late GlobalKey<ScaffoldState> scaffoldKey;

  SmartCoachChatCubit(
    this._geminiService,
    this._createChat,
    this._getAllChats,
    this._insertMessage,
    this._getMessages,
  ) : super(const SmartCoachChatState());
  final TextEditingController messageController = TextEditingController();

  Future<void> doIntent(SmartCoachChatIntent intent) async {
    switch (intent) {
      case InitSmartCoachChat():
        _onInit();
        break;
      case SendMessageIntent():
        await _handleSendMessage(intent.message);
        break;
      case LoadChatIntent():
        await _loadChat(chatId: intent.chatId, title: intent.title);
        break;
    }
  }

  Future<void> _loadAllChats() async {
    emit(state.copyWith(loadChatsStatus: const StateStatus.loading()));

    try {
      final chats = await _getAllChats();
      emit(
        state.copyWith(
          allChats: chats,
          loadChatsStatus: const StateStatus.success(null),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadChatsStatus: StateStatus.failure(
            ResponseException(message: e.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _loadChat({int? chatId, String? title}) async {
    if (chatId != null) {
      await _loadMessages(chatId);
    } else {
      final newChatId = await _createChat(title: title);
      emit(state.copyWith(currentChatId: newChatId, messages: const []));
      await _loadAllChats();
    }
  }

  Future<void> _loadMessages(int chatId) async {
    final savedMessages = await _getMessages(chatId);
    final messages = savedMessages
        .map(
          (m) => ChatMessage(
            message: m['content'] as String,
            isUser: (m['role'] as String) == 'user',
          ),
        )
        .toList();

    emit(state.copyWith(messages: messages, currentChatId: chatId));
  }

  Future<void> _onInit() async {
    scaffoldKey = GlobalKey<ScaffoldState>();
    await _loadAllChats();
    emit(
      state.copyWith(
        messages: const [],
        sendMessageStatus: const StateStatus.success(null),
      ),
    );
  }

  Future<void> _handleSendMessage(String message) async {
    if (message.trim().isEmpty) return;
    final chatId =
        state.currentChatId ??
        await _createChat(
          title: message.isNotEmpty ? message : "Untitled Chat",
        );
    final updatedMessages = List<ChatMessage>.of(state.messages)
      ..add(ChatMessage(message: message, isUser: true));

    messageController.clear();

    await _insertMessage(chatId: chatId, role: 'user', content: message);

    emit(
      state.copyWith(
        sendMessageStatus: const StateStatus.loading(),
        messages: updatedMessages,
        currentChatId: chatId,
      ),
    );

    try {
      final reply = await _geminiService.sendMessage(message);

      updatedMessages.add(ChatMessage(message: reply, isUser: false));
      await _insertMessage(chatId: chatId, role: 'assistant', content: reply);

      emit(
        state.copyWith(
          sendMessageStatus: const StateStatus.success(null),
          messages: updatedMessages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          sendMessageStatus: StateStatus.failure(
            ResponseException(message: e.toString()),
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
