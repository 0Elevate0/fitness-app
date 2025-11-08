import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_section.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_bot_loading.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_section_test.mocks.dart';

@GenerateMocks([SmartCoachChatCubit])
void main() {
  late MockSmartCoachChatCubit mockCubit;

  setUp(() {
    mockCubit = MockSmartCoachChatCubit();
    when(mockCubit.state).thenReturn(const SmartCoachChatState(sendMessageStatus: StateStatus.loading()));
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget prepareWidget({required List<ChatMessage> messages, required SmartCoachChatState state}) {
    when(mockCubit.state).thenReturn(state);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<SmartCoachChatCubit>.value(
            value: mockCubit,
            child: ChatSection(messages: messages),
          ),
        );
      },
    );
  }
  testWidgets('ChatSection shows messages only when not loading', (tester) async {
    final messages = [
      const ChatMessage(message: 'Hello 1', isUser: true),
      const ChatMessage(message: 'Hello 2', isUser: false),
    ];
    final state = const SmartCoachChatState(sendMessageStatus: StateStatus.initial());

    await tester.pumpWidget(prepareWidget(messages: messages, state: state));
    await tester.pump();

    expect(find.text('Hello 1'), findsOneWidget);
    expect(find.text('Hello 2'), findsOneWidget);
    expect(find.byType(ChatBotLoading), findsNothing);
  });

  testWidgets('ChatSection shows ChatBotLoading when loading', (tester) async {
    final messages = [
      const ChatMessage(message: 'Hello 1', isUser: true),
    ];
    final state = const SmartCoachChatState(sendMessageStatus: StateStatus.loading());

    await tester.pumpWidget(prepareWidget(messages: messages, state: state));
    await tester.pump();

    expect(find.text('Hello 1'), findsOneWidget);
    expect(find.byType(ChatBotLoading), findsOneWidget);
  });

}
