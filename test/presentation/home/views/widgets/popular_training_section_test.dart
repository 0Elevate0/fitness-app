import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/popular_training_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/popular_training_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: PopularTrainingSection());
      },
    );
  }

  testWidgets("Verifying PopularTrainingSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(PopularTrainingList), findsOneWidget);
    expect(find.text(AppText.popularTraining.tr()), findsOneWidget);
  });
}
