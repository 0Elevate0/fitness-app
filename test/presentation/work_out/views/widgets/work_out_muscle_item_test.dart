import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  const testName = 'Chest';
  const testImage = 'https://example.com/chest.png';
  const testMuscle = MuscleEntity(id: '1', name: testName, image: testImage);

  Widget buildTestableWidget(MuscleEntity muscle) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: Scaffold(body: WorkOutMuscleItem(muscleData: muscle)),
        ),
      ),
    );
  }

  testWidgets('renders muscle name and image correctly', (tester) async {
    // Act
    await tester.pumpWidget(buildTestableWidget(testMuscle));

    // Assert
    expect(find.text(testName), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.image?.image, isA<CachedNetworkImageProvider>());
  });

  testWidgets('uses fallback image when muscle image is null', (tester) async {
    // Arrange
    const muscleWithoutImage = MuscleEntity(id: '2', name: 'Legs', image: null);

    // Act
    await tester.pumpWidget(buildTestableWidget(muscleWithoutImage));

    // Assert
    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.image?.image, isA<AssetImage>());

    final assetImage = decoration.image!.image as AssetImage;
    expect(assetImage.assetName, AppImages.notFound);
  });

  testWidgets('responds to tap gesture', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: WorkOutMuscleItem(
                muscleData: const MuscleEntity(
                  id: '3',
                  name: 'Back',
                  image: null,
                ),
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(WorkOutMuscleItem));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
