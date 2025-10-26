import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/forget_password_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget buildTestWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MaterialApp(home: Scaffold(body: ForgetPasswordButton())),
    );
  }

  testWidgets('ForgetPasswordButton displays correct text and style', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final textFinder = find.text(AppText.forgetPasswordLogin.tr());
    expect(textFinder, findsOneWidget);

    final Text textWidget = tester.widget(textFinder);
    final BuildContext context = tester.element(textFinder);
    final theme = Theme.of(context);

    expect(textWidget.style?.color, theme.colorScheme.primary);
    expect(textWidget.style?.decoration, TextDecoration.underline);
    expect(textWidget.style?.decorationColor, theme.colorScheme.primary);
  });
}
