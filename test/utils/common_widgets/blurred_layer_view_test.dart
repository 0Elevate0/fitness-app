import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
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
          home: Scaffold(body: BlurredLayerView(child: Column())),
        );
      },
    );
  }

  testWidgets("Verifying BlurredLayerView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(Container), findsNWidgets(2));
    expect(find.byType(BackdropFilter), findsOneWidget);
  });
}
