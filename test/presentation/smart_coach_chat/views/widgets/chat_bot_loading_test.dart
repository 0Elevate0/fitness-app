import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_bot_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: ChatBotLoading(),
          ),
        );
      },
    );
  }

  testWidgets('ChatBotLoading shows image container and progress indicator', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());

     final containerFinder = find.byWidgetPredicate(
          (widget) =>
      widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image != null,
    );
    expect(containerFinder, findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    expect(find.byType(Row), findsOneWidget);
  });
}
