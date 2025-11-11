import 'package:fitness_app/presentation/home/views/widgets/popular_training_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/popular_training_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: PopularTrainingList());
      },
    );
  }

  testWidgets("Verifying PopularTrainingList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(PopularTrainingItem), findsWidgets);
  });
}
