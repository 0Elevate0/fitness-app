import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/presentation/profile/view/widgets/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: LogoutConfirmationDialog(),
          ),
        ),
      ),
    );
  }

  testWidgets('renders dialog text and buttons correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.text('Are You Sure To Close The Application?'), findsOneWidget);
    expect(find.text('Yes'), findsOneWidget);
    expect(find.text('No'), findsOneWidget);
  });

  testWidgets('pressing No closes the dialog', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();

    expect(find.text('Are You Sure To Close The Application?'), findsNothing);
  });

  testWidgets('pressing Yes removes token and navigates to login', (tester) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '123');

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();

    final token = prefs.getString('token');
    expect(token, isNull);
  });
}
