import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_details/ingredient_measure_entity.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/presentation/food/food_details/view/widgets/food_details_view_body.dart';
import 'package:fitness_app/presentation/food/food_details/view/widgets/nutrient_circle.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_cubit.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_widget_test.mocks.dart';

@GenerateMocks([FoodDetailsCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFoodDetailsCubit mockCubit;
  const testMealId = '52959';

  const mockMealEntity = MealDetailsEntity(
    idMeal: testMealId,
    strMeal: 'Test Salmon Dish',
    strInstructions: 'Test instructions. This is a mock description.',
    strMealThumb: 'https://test.com/salmon.jpg',
    ingredients: [
      IngredientMeasureEntity(ingredient: 'Fennel', measure: '2 medium'),
      IngredientMeasureEntity(ingredient: 'Parsley', measure: '2 tbs chopped'),
    ],
  );

  const mockSuccessState = FoodDetailsState(
    mealDetailsStatus: StateStatus.success(mockMealEntity),
  );

  Widget createTestApp({required Widget child}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(body: child),
          ),
        );
      },
      child: child,
    );
  }

  setUp(() {
    mockCubit = MockFoodDetailsCubit();
    getIt.registerFactory<FoodDetailsCubit>(() => mockCubit);
    provideDummy<FoodDetailsState>(const FoodDetailsState());

    when(mockCubit.state).thenReturn(mockSuccessState);
    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([mockSuccessState]));
  });

  group('NutrientCircle Widget Test', () {
    testWidgets('Verifying NutrientCircle displays value and label', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          child: const NutrientCircle(value: "100 K", label: "energy"),
        ),
      );

      expect(find.text("100 K"), findsOneWidget);
      expect(find.text("energy"), findsOneWidget);
    });
  });

  group('FoodDetailsViewBody Widget Test', () {
    testWidgets('Verify success state displays meal details and ingredients', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          child: BlocProvider<FoodDetailsCubit>.value(
            value: mockCubit,
            child: const FoodDetailsViewBody(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Salmon Dish'), findsOneWidget);
      expect(find.textContaining('This is a mock description'), findsOneWidget);

      expect(find.text('Fennel'), findsOneWidget);
      expect(find.text('2 tbs chopped'), findsOneWidget);

      expect(find.byWidgetPredicate(
            (widget) => widget is ClipRRect && widget.child is BackdropFilter,
      ), findsOneWidget);
    });

    testWidgets('Verify loading state displays CircularProgressIndicator', (tester) async {
      when(mockCubit.state).thenReturn(const FoodDetailsState(mealDetailsStatus: StateStatus.loading()));
      when(mockCubit.stream).thenAnswer((_) => Stream.value(const FoodDetailsState(mealDetailsStatus: StateStatus.loading())));

      await tester.pumpWidget(
        createTestApp(
          child: BlocProvider<FoodDetailsCubit>.value(
            value: mockCubit,
            child: const FoodDetailsViewBody(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Salmon Dish'), findsNothing);
    });
  });

  tearDown(() {
    getIt.reset();
  });
}