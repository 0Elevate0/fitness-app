import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/presentation/food/views/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(MealEntity mealData) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: Scaffold(body: MealItem(mealData: mealData)),
      ),
    );
  }

  testWidgets('renders meal name correctly', (WidgetTester tester) async {
    final meal = const MealEntity(id: '1', name: 'Omelette', thumbnail: null);

    await tester.pumpWidget(buildTestableWidget(meal));

    // Check that the text is displayed
    expect(find.text('Omelette'), findsOneWidget);
  });

  testWidgets('calls onTap callback when tapped', (WidgetTester tester) async {
    final meal = const MealEntity(id: '1', name: 'Omelette', thumbnail: null);

    var tapped = false;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: MealItem(mealData: meal, onTap: () => tapped = true),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(MealItem));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('renders CachedNetworkImage when thumbnail is provided', (
    WidgetTester tester,
  ) async {
    final meal = const MealEntity(
      id: '1',
      name: 'Omelette',
      thumbnail: 'https://example.com/image.jpg',
    );

    await tester.pumpWidget(buildTestableWidget(meal));

    // Pick the container that has a DecorationImage
    final container = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
      ),
    );

    final decoration = container.decoration as BoxDecoration;
    final image = decoration.image!.image;

    expect(image, isA<CachedNetworkImageProvider>());
  });

  testWidgets('renders AssetImage when thumbnail is null', (
    WidgetTester tester,
  ) async {
    final meal = const MealEntity(id: '1', name: 'Omelette', thumbnail: null);

    await tester.pumpWidget(buildTestableWidget(meal));

    // Pick the container that has a DecorationImage
    final container = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
      ),
    );

    final decoration = container.decoration as BoxDecoration;
    final image = decoration.image?.image;

    expect(image, isA<AssetImage>());
    expect((image as AssetImage).assetName, AppImages.foodNotFound);
  });
}
