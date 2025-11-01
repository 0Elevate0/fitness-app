import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_recommendation_item.dart';
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
          home: FoodRecommendationItem(
            mealData: MealEntity(name: "meat", id: "12", thumbnail: "image"),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodRecommendationItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(BlurredContainer), findsWidgets);
    expect(find.byType(ClipRRect), findsWidgets);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsOneWidget);
  });
}
