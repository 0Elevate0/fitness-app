import 'package:fitness_app/presentation/food_details/views/widgets/loading_food_details.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: LoadingFoodDetails());
      },
    );
  }

  testWidgets("Verifying LoadingFoodDetails Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(AnimationLoaderWidget), findsOneWidget);
  });
}
