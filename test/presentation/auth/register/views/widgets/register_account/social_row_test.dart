import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/social_row.dart';
import 'package:fitness_app/utils/common_widgets/circular_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: Scaffold(body: SocialRow()));
      },
    );
  }

  testWidgets("Verifying SocialRow Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(CircularSvgIcon), findsNWidgets(3));
    expect(find.byType(RSizedBox), findsNWidgets(2));
  });
}
