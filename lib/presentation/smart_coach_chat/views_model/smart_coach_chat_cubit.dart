import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/data/ai/gemini_service.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class SmartCoachChatCubit extends Cubit<SmartCoachChatState> {
  final GeminiService _geminiService;

  SmartCoachChatCubit(this._geminiService) : super(const SmartCoachChatState());
  final TextEditingController messageController = TextEditingController();

  Future<void> doIntent(SmartCoachChatIntent intent) async {
    switch (intent) {
      case InitSmartCoachChat():
        await _onInit();
        break;
      case SendMessageIntent():
        await _handleSendMessage(intent.message);
        break;
    }
  }

  Future<void> _onInit() async {
    emit(
      state.copyWith(
        messages: const [],
        sendMessageStatus: const StateStatus.success(null),
      ),
    );
  }

  Future<void> _handleSendMessage(String message) async {
    if (message.trim().isEmpty) return;
    final updatedMessages = List<ChatMessage>.of(state.messages)
      ..add(ChatMessage(message: message, isUser: true));

    emit(
      state.copyWith(
        sendMessageStatus: const StateStatus.loading(),
        messages: updatedMessages,
      ),
    );

    try {
      final replay = await _geminiService.sendMessage(message);
      updatedMessages.add(ChatMessage(message: replay, isUser: false));

      emit(
        state.copyWith(
          sendMessageStatus: const StateStatus.success(null),
          messages: updatedMessages,
        ),
      );
      messageController.clear();
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
