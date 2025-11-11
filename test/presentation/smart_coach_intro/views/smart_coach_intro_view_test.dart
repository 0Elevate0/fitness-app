import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/smart_coach_intro_view.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_body_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

 void main() {
  TestWidgetsFlutterBinding.ensureInitialized();



  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: SmartCoachIntroView(),
        );
      },
    );
  }

  testWidgets("Verifying SmartCoachIntroView UI Structure", (tester) async {
    // Arrange
    await tester.pumpWidget(prepareWidget());

    // Assert
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SmartCoachIntroBodyView), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;

    expect(decoration.image, isNotNull);
    expect(decoration.image!.fit, BoxFit.cover);
  });

  tearDown(() {
    getIt.reset();
  });
}
