import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/popular_training/popular_training_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/popular_training_item.dart';
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
          home: PopularTrainingItem(
            popularTrainingData: PopularTrainingEntity(
              backgroundImage: AppImages.popular1,
              title: '',
              numberOfTasks: 5,
              level: '',
              levelId: '',
              muscleId: '',
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying PopularTrainingItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(3));
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(BlurredContainer), findsNWidgets(3));
    expect(find.byType(ClipRRect), findsWidgets);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.textContaining(AppText.tasks.tr()), findsOneWidget);
  });
}
