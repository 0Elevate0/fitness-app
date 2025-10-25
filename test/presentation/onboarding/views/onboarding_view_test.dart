import 'package:fitness_app/presentation/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  Widget prepareWidgetUnderTest(){
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context,child){
        return const MaterialApp(
          home:OnboardingView()

        );
      },
    );
  }
  testWidgets("verify onboarding  structure", (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidgetUnderTest());
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget)=>widget is Container && widget.child is Scaffold)
        ,findsOneWidget);

    expect(find.byType(OnboardingView),findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);

  });

}