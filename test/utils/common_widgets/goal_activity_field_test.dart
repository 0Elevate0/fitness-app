import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(body: GoalActivityField(title: 'fitness')),
        );
      },
    );
  }

  testWidgets("Verifying GoalActivityField Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}
