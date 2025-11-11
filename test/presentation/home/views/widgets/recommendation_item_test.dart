import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/recommendation_item.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
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
          home: RecommendationItem(
            muscleData: MuscleEntity(id: "id", name: "name", image: "image"),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RecommendationItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}
