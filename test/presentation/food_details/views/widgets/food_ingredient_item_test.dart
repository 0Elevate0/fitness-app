import 'package:fitness_app/presentation/food_details/views/widgets/food_ingredient_item.dart';
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
          home: FoodIngredientItem(
            mealIngredient: "mealIngredient",
            mealMeasure: "mealMeasure",
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodIngredientItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsOneWidget);
  });
}
