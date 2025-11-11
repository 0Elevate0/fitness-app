import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/widgets/category_group_item.dart';
import 'package:fitness_app/presentation/food/views/widgets/category_list.dart';
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
            child: const Scaffold(body: CategoryList()),
          ),
        ),
      ),
    );
  }

  testWidgets('shows Food group items when success with data', (
    WidgetTester tester,
  ) async {
    final mockGroups = [
      const MealCategoryEntity(idCategory: '1', strCategory: 'beef'),
      const MealCategoryEntity(idCategory: '2', strCategory: 'chicken'),
    ];

    final state = FoodState(
      mealsArgument: MealsArgument(categories: mockGroups),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pumpAndSettle();

    expect(find.byType(CategoryGroupItem), findsNWidgets(2));
  });
}
