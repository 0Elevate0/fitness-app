import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/domain/entities/category/category_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/category_item.dart';
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
          home: CategoryItem(
            categoryData: CategoryEntity(
              categoryTitle: "",
              categoryImage: AppImages.category1,
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CategoryItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}
