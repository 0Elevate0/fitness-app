import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: ProfileAvatar());
      },
    );
  }

  testWidgets("Verifying ProfileAvatar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Text), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
