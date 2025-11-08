 import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_drawer.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
 import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_drawer_test.mocks.dart';

@GenerateMocks([SmartCoachChatCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSmartCoachChatCubit mockCubit;

   final mockChats = [
    {"id": 1, "title": "Chat 1"},
    {"id": 2, "title": "Chat 2"},
  ];

  setUp(() {
    mockCubit = MockSmartCoachChatCubit();

    when(mockCubit.state).thenReturn(SmartCoachChatState(allChats: mockChats));
    when(mockCubit.stream).thenAnswer((_) => Stream.value(mockCubit.state));
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: BlocProvider<SmartCoachChatCubit>.value(
              value: mockCubit,
              child: const ChatDrawer(),
            ),
          ),
        );
      },
    );
  }

  testWidgets('ChatDrawer taps on chat item trigger LoadChatIntent', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Chat 1'));
    await tester.pumpAndSettle();

    verify(mockCubit.doIntent(any)).called(1);
  });
}
