import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_selection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: ProfileSelectionItem(prefixIcon: AppIcons.logout),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ProfileSelectionItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Row), findsNWidgets(2));
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(FittedBox), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(RSizedBox), findsNWidgets(2));
  });

  tearDown(() {
    getIt.reset();
  });
}
