import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/home/views/widgets/categories_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/category_item.dart';
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
        return const MaterialApp(home: CategoriesSection());
      },
    );
  }

  testWidgets("Verifying CategoriesSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.text(AppText.category.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is CategoryItem,
      ),
      findsWidgets,
    );
  });
}
