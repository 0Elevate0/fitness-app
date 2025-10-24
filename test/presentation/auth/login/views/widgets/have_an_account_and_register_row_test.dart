import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/have_an_account_and_register_row.dart';
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
      child: const MaterialApp(
        home: Scaffold(body: HaveAnAccountAndRegisterRow()),
      ),
    );
  }

  testWidgets(
    'HaveAnAccountAndRegisterRow displays texts and styles correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final haveAccountFinder = find.text(AppText.donNotHaveAccount.tr());
      final registerFinder = find.text(AppText.register.tr());

      expect(haveAccountFinder, findsOneWidget);
      expect(registerFinder, findsOneWidget);

      final Text haveAccountText = tester.widget(haveAccountFinder);
      final Text registerText = tester.widget(registerFinder);

      final BuildContext context = tester.element(registerFinder);
      final theme = Theme.of(context);

      expect(haveAccountText.style?.fontWeight, FontWeight.w400);
      expect(registerText.style?.color, theme.colorScheme.primary);
      expect(registerText.style?.decoration, TextDecoration.underline);
      expect(registerText.style?.decorationColor, theme.colorScheme.primary);
    },
  );
}
