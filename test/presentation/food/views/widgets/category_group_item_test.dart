import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/presentation/food/views/widgets/category_group_item.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_group_item_test.mocks.dart';

@GenerateMocks([FoodCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodCubit mockFoodCubit;
  provideDummy<FoodState>(const FoodState());

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  setUp(() {
    mockFoodCubit = MockFoodCubit();
    when(mockFoodCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockFoodCubit.state).thenReturn(const FoodState());
  });

  Widget buildTestableWidget({
    required MealCategoryEntity group,
    required bool isSelected,
  }) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<FoodCubit>.value(
            value: mockFoodCubit,
            child: Scaffold(
              body: CategoryGroupItem(
                mealCategoryData: group,
                isSelected: isSelected,
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders correctly and calls cubit.doIntent on tap', (
    WidgetTester tester,
  ) async {
    // Arrange
    final group = const MealCategoryEntity(
      idCategory: '1',
      strCategory: 'beef',
    );
    when(
      mockFoodCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(
      buildTestableWidget(group: group, isSelected: false),
    );

    // Assert initial UI
    expect(find.text('beef'), findsOneWidget);

    // Act
    await tester.tap(find.byType(CategoryGroupItem));
    await tester.pumpAndSettle();

    // Assert
    verify(mockFoodCubit.doIntent(intent: anyNamed('intent'))).called(2);
  });

  testWidgets('applies selected style when isSelected is true', (
    WidgetTester tester,
  ) async {
    // Arrange
    final group = const MealCategoryEntity(
      idCategory: '1',
      strCategory: 'beef',
    );

    await tester.pumpWidget(
      buildTestableWidget(group: group, isSelected: true),
    );

    // Assert
    final container = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, isNotNull); // Should have a selected color
  });
}
