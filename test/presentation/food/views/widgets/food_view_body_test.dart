import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/widgets/category_list.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_view_body.dart';
import 'package:fitness_app/presentation/food/views/widgets/meals_list.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_view_body_test.mocks.dart';

@GenerateMocks([FoodCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFoodCubit mockFoodCubit;
  late PageController mockPageController;
  provideDummy<FoodState>(const FoodState());

  const tCategory = MealCategoryEntity(
    idCategory: '1',
    strCategory: 'Beef',
    strCategoryThumb: 'thumb.jpg',
  );
  const tCategory2 = MealCategoryEntity(
    idCategory: '2',
    strCategory: 'Chicken',
    strCategoryThumb: 'thumb2.jpg',
  );
  const tArgument = MealsArgument(
    selectedCategory: tCategory,
    categories: [tCategory, tCategory2],
  );

  setUp(() {
    mockFoodCubit = MockFoodCubit();
    mockPageController = PageController();
    when(mockFoodCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockFoodCubit.state).thenReturn(
      const FoodState(
        mealsArgument: tArgument,
        tabIndex: 0,
        selectedCategory: tCategory,
        mealsListStatus: StateStatus.success([]),
      ),
    );

    when(mockFoodCubit.pageController).thenReturn(mockPageController);
    when(
      mockFoodCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});
  });

  tearDown(() {
    mockPageController.dispose();
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: BlocProvider<FoodCubit>.value(
          value: mockFoodCubit,
          child: const Scaffold(body: FoodViewBody()),
        ),
      ),
    );
  }

  testWidgets('renders CategoryList and MealsList', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CategoryList), findsOneWidget);
    expect(find.byType(MealsList), findsOneWidget);
  });

  testWidgets('fires intents on PageView swipe', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    await tester.drag(find.byType(PageView), const Offset(-1000.0, 0.0));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    verify(mockFoodCubit.doIntent(intent: anyNamed('intent'))).called(2);
  });
}
