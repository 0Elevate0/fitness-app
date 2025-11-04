import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget() {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
      child: MaterialApp(home: Scaffold(body: ProfileResetPasswordAppBar())),
    );
  }

  testWidgets('renders ProfileResetPasswordAppBar with logo image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(ProfileResetPasswordAppBar), findsOneWidget);

    expect(find.byType(CustomAppBar), findsOneWidget);

    final image = tester.widget<Image>(find.byType(Image));
    final imageProvider = image.image as AssetImage;
    expect(imageProvider.assetName, AppImages.superFitness);
  });
}
