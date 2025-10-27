import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/pin_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

   SharedPreferences.setMockInitialValues({});
  const MethodChannel('plugins.flutter.io/shared_preferences')
      .setMockMethodCallHandler((_) async => {});

  await EasyLocalization.ensureInitialized();

  late TextEditingController controller;

  setUp(() {
    controller = TextEditingController();
  });

  Widget buildTestableWidget(Widget child) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, _) => MaterialApp(
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  testWidgets('renders PinCodeWidget normally', (tester) async {
    await tester.pumpWidget(buildTestableWidget(
      PinCodeWidget(
        verificationController: controller,
        onSubmitted: (_) {},
        isError: false,
      ),
    ));

     await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(TextField), findsWidgets);
    expect(find.text(AppText.invalidCode.tr()), findsNothing);
  });

  testWidgets('shows error message when isError is true', (tester) async {
    await tester.pumpWidget(buildTestableWidget(
      PinCodeWidget(
        verificationController: controller,
        onSubmitted: (_) {},
        isError: true,
      ),
    ));

    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(AppText.invalidCode.tr()), findsOneWidget);
    expect(find.byIcon(Icons.error), findsOneWidget);
  });
}
