import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_body_view.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          routes: {
            RouteNames.smartCoachChat: (context) => const Scaffold(
              body: Center(child: Text("SmartCoachChat Page")),
            ),
          },
          home: const SmartCoachIntroBodyView(),
        );
      },
    );
  }

  testWidgets("Verify SmartCoachIntroBodyView structure", (tester) async {
    await tester.pumpWidget(prepareWidget());

    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SmartCoachIntroAppBar), findsOneWidget);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });

  testWidgets("Tapping button navigates to SmartCoachChat", (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text("SmartCoachChat Page"), findsOneWidget);
  });
}
