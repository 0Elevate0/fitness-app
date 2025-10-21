import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/have_account_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: Scaffold(body: HaveAccountRow()));
      },
    );
  }

  testWidgets("Verifying HaveAccountRow Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Flexible), findsNWidgets(2));
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.text(AppText.haveAccountMessage.tr()), findsOneWidget);
    expect(find.text(" ${AppText.login.tr()}"), findsOneWidget);
  });
}
