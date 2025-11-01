import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/widgets/meal_item.dart';
import 'package:fitness_app/presentation/food/views/widgets/meals_list.dart';
import 'package:fitness_app/presentation/food/views/widgets/shimmer/meals_grid_shimmer.dart';
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
  late MockFoodCubit mockCubit;
  provideDummy<FoodState>(const FoodState());

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockFoodCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state).thenReturn(const FoodState());
  });

  Widget buildTestableWidget(FoodState state) {
    when(mockCubit.state).thenReturn(state);
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<FoodCubit>.value(
            value: mockCubit,
            child: const Scaffold(body: MealsList()),
          ),
        ),
      ),
    );
  }

  testWidgets('shows shimmer when loading', (WidgetTester tester) async {
    final state = const FoodState(mealsListStatus: StateStatus.loading());

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.byType(MealsGridShimmer), findsOneWidget);
  });

  testWidgets('shows empty message when no foodList', (
    WidgetTester tester,
  ) async {
    final mockGroup = const MealCategoryEntity(
      idCategory: '1',
      strCategory: 'beef',
    );
    final state = FoodState(
      mealsListStatus: const StateStatus.success([]),
      mealsArgument: MealsArgument(
        categories: const [],
        selectedCategory: mockGroup,
      ),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.text(AppText.emptyFoodGroupMessage.tr()), findsOneWidget);
  });

  testWidgets('shows Food grid when data available', (
    WidgetTester tester,
  ) async {
    final mockGroup = const MealCategoryEntity(
      idCategory: '1',
      strCategory: 'beef',
    );
    final mockFoodList = [
      const MealEntity(id: 'm1', name: 'stick'),
      const MealEntity(id: 'm2', name: 'iceCream'),
    ];
    final state = FoodState(
      mealsListStatus: StateStatus.success(mockFoodList),
      mealsArgument: MealsArgument(
        categories: [mockGroup],
        selectedCategory: mockGroup,
      ),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.byType(MealItem), findsNWidgets(2));
  });
}
