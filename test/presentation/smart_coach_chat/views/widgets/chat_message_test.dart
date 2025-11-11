import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget({required String message, required bool isUser}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: ChatMessage(message: message, isUser: isUser),
          ),
        );
      },
    );
  }

  testWidgets('ChatMessage shows bot message correctly', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget(message: 'Hello Bot', isUser: false));
    await tester.pumpAndSettle();

     expect(find.text('Hello Bot'), findsOneWidget);

     final botAvatarFinder = find.byWidgetPredicate(
          (widget) =>
      widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image != null,
    );
    expect(botAvatarFinder, findsOneWidget);
  });

  testWidgets('ChatMessage shows user message correctly', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget(message: 'Hello User', isUser: true));
    await tester.pumpAndSettle();

     expect(find.text('Hello User'), findsOneWidget);


    final userAvatarFinder = find.byWidgetPredicate(
          (widget) =>
      widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image != null,
    );
    expect(userAvatarFinder, findsOneWidget);
  });
}
