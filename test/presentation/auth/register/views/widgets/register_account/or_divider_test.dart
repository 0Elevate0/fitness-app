import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: Scaffold(body: OrDivider()));
      },
    );
  }

  testWidgets("Verifying OrDivider Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Container), findsNWidgets(3));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.text(AppText.or.tr()), findsOneWidget);
  });
}
