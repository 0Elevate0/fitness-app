import 'package:fitness_app/utils/common_widgets/play_video_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: PlayVideoButton());
      },
    );
  }

  testWidgets("Verifying PlayVideoButton Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
