import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: HomeAppBar());
      },
    );
  }

  testWidgets("Verifying HomeAppBar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.textContaining(AppText.hi.tr()), findsOneWidget);
    expect(find.text(AppText.startYourDay.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
