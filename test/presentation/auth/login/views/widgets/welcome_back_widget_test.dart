import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/welcome_back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        home: ScreenUtilInit(
          designSize: Size(375, 812),
          child: Scaffold(body: WelcomeBackWidget()),
        ),
      ),
    );
  }

  testWidgets('WelcomeBackWidget displays correct texts and styles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final theme = Theme.of(tester.element(find.byType(WelcomeBackWidget)));

    final heyThereFinder = find.text(AppText.heyThere.tr());
    final welcomeBackFinder = find.text(AppText.welcomeBack.tr());

    expect(heyThereFinder, findsOneWidget);
    expect(welcomeBackFinder, findsOneWidget);

    final Text heyThereText = tester.widget(heyThereFinder);
    final Text welcomeBackText = tester.widget(welcomeBackFinder);

    expect(heyThereText.style, theme.textTheme.headlineSmall);
    expect(welcomeBackText.style, theme.textTheme.headlineMedium);
  });
}
