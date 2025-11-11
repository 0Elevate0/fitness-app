import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/create_new_password_section.dart';
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
          child: Scaffold(body: CreateNewPasswordSection()),
        ),
      ),
    );
  }

  testWidgets('CreateNewPasswordSection displays correct texts and styles', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final theme = Theme.of(
      tester.element(find.byType(CreateNewPasswordSection)),
    );

    final makeSureFinder = find.text(AppText.makeSureIts8CharactersOrMore.tr());
    final createNewPasswordFinder = find.text(AppText.createNewPassword.tr());

    expect(makeSureFinder, findsOneWidget);
    expect(createNewPasswordFinder, findsOneWidget);

    final Text makeSureText = tester.widget(makeSureFinder);
    final Text createNewPasswordText = tester.widget(createNewPasswordFinder);

    expect(makeSureText.style, theme.textTheme.headlineSmall);
    expect(createNewPasswordText.style, theme.textTheme.headlineMedium);
  });
}
