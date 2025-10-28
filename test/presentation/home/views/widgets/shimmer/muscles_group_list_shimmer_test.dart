import 'package:fitness_app/presentation/home/views/widgets/shimmer/muscles_group_list_shimmer.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(home: MusclesGroupListShimmer());
      },
    );
  }

  testWidgets("Verifying MusclesGroupListShimmer Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(ListView), findsWidgets);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is ShimmerEffect,
      ),
      findsWidgets,
    );
    expect(find.byType(RSizedBox), findsWidgets);
  });
}
