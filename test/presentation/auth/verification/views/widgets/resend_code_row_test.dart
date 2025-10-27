import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/resend_code_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest({
    required bool isDisabled,
    VoidCallback? onResend,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: ResendCodeRow(
            isDisabled: isDisabled,
            onResend: onResend,
          ),
        ),
      ),
    );
  }

  testWidgets('renders ResendCodeRow correctly when enabled', (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      createWidgetUnderTest(
        isDisabled: false,
        onResend: () => tapped = true,
      ),
    );

    await tester.pump();

     expect(find.text(AppText.resendCode), findsOneWidget);

    final textWidget = tester.widget<Text>(find.text(AppText.resendCode));
    expect(textWidget.style?.color, isNot(AppColors.gray));

    await tester.tap(find.text(AppText.resendCode));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('renders ResendCodeRow correctly when disabled', (tester) async {
    await tester.pumpWidget(
      createWidgetUnderTest(
        isDisabled: true,
        onResend: () {},
      ),
    );

    await tester.pump();

    final textWidget = tester.widget<Text>(find.text(AppText.resendCode));
    expect(textWidget.style?.color, AppColors.gray);
  });
}
