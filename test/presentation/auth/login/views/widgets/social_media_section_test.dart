import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/social_media_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) =>
            const MaterialApp(home: Scaffold(body: SocialMediaSection())),
      ),
    );
  }

  testWidgets('renders OR text (localized) and 3 social media icons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppText.or.tr()), findsOneWidget);

    expect(find.byType(SvgPicture), findsNWidgets(3));

    final svgFinder = find.byType(SvgPicture);
    final icons = [AppIcons.faceBook, AppIcons.google, AppIcons.apple];

    for (var icon in icons) {
      expect(
        svgFinder,
        findsWidgets,
        reason: 'Expected to find SVG icon: $icon',
      );
    }
  });
}
