import 'package:fitness_app/utils/common_widgets/bracket_text.dart';
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
          home: Scaffold(
            body: BracketText(
              textInside: "textInside",
              textOutside: "textOutside",
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying BracketText Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Flexible), findsNWidgets(2));
    expect(find.byType(FittedBox), findsNWidgets(3));
    expect(find.byType(Text), findsNWidgets(3));
  });
}
