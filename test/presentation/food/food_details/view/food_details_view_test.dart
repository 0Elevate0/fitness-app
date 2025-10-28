
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_details/ingredient_measure_entity.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/presentation/food/food_details/view/food_details_screen.dart';
import 'package:fitness_app/presentation/food/food_details/view/widgets/food_details_view_body.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_cubit.dart';
import 'package:fitness_app/presentation/food/food_details/view_models/food_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_details_view_test.mocks.dart';

@GenerateMocks([FoodDetailsCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFoodDetailsCubit mockCubit;
  const testMealId = '52959';

  const mockMealEntity = MealDetailsEntity(
    idMeal: testMealId,
    strMeal: 'Test Salmon Dish',
    strInstructions: 'This is a test description.',
    strMealThumb: 'https://test.com/salmon.jpg',
    ingredients: [
      IngredientMeasureEntity(ingredient: 'Test Ingredient', measure: '10 g'),
    ],
  );

  const mockSuccessState = FoodDetailsState(
    mealDetailsStatus: StateStatus.success(mockMealEntity),
  );

  setUp(() {
    mockCubit = MockFoodDetailsCubit();

    getIt.registerFactory<FoodDetailsCubit>(() => mockCubit);

    provideDummy<FoodDetailsState>(const FoodDetailsState());

    when(mockCubit.state).thenReturn(mockSuccessState);
    when(mockCubit.stream).thenAnswer(
          (_) => Stream.fromIterable([mockSuccessState]),
    );

  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<FoodDetailsCubit>.value(
            value: mockCubit,
            child: const FoodDetailsView(mealId: testMealId),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodDetailsView components and Cubit intent call", (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(BlocProvider<FoodDetailsCubit>), findsOneWidget);

    expect(find.byType(FoodDetailsViewBody), findsOneWidget);

    expect(find.text('Test Salmon Dish'), findsOneWidget);
  });

  testWidgets("Verifying loading state shows CircularProgressIndicator", (tester) async {
    when(mockCubit.state).thenReturn(const FoodDetailsState(mealDetailsStatus: StateStatus.loading()));
    when(mockCubit.stream).thenAnswer((_) => Stream.value(const FoodDetailsState(mealDetailsStatus: StateStatus.loading())));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    expect(find.text('Test Salmon Dish'), findsNothing);

    expect(find.byType(FoodDetailsViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}