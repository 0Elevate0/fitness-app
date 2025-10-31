import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
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
        child: MaterialApp(home: Scaffold(body: WorkOutAppBar())),
      ),
    );
  }

  testWidgets('renders workout title correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text(tr(AppText.workout)), findsOneWidget);


    final textWidget = tester.widget<Text>(find.text(tr(AppText.workout)));
    expect(textWidget.style?.fontWeight, FontWeight.w600);
  });
}
