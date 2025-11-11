import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_ingredient_item.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_ingredients_section.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_ingredients_section_test.mocks.dart';

@GenerateMocks([FoodDetailsCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodDetailsCubit mockFoodDetailsCubit;
  setUp(() {
    mockFoodDetailsCubit = MockFoodDetailsCubit();
    getIt.registerFactory<FoodDetailsCubit>(() => mockFoodDetailsCubit);
    provideDummy<FoodDetailsState>(const FoodDetailsState());
    when(mockFoodDetailsCubit.state).thenReturn(
      const FoodDetailsState(
        mealsDetailsStatus: StateStatus.success(
          MealDetailsEntity(mealId: "123", mealTitle: "meat"),
        ),
        mealsRecommendation: [
          MealEntity(id: "1234", name: "meat", thumbnail: "image"),
          MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
        ],
        allCategoryMeals: [
          MealEntity(id: "1234", name: "meat", thumbnail: "image"),
          MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
        ],
        mealIngredients: ["1", "2", "3"],
        mealMeasures: ["1", "2", "3"],
      ),
    );
    when(mockFoodDetailsCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const FoodDetailsState(
          mealsDetailsStatus: StateStatus.success(
            MealDetailsEntity(mealId: "123", mealTitle: "meat"),
          ),
          mealsRecommendation: [
            MealEntity(id: "1234", name: "meat", thumbnail: "image"),
            MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
          ],
          allCategoryMeals: [
            MealEntity(id: "1234", name: "meat", thumbnail: "image"),
            MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
          ],
          mealIngredients: ["1", "2", "3"],
          mealMeasures: ["1", "2", "3"],
        ),
      ]),
    );
  });

  // Arrange
  Widget prepareWidget() {
    final foodDetailsArgument = const FoodDetailsArgument(
      mealsData: [
        MealEntity(id: "1234", name: "meat", thumbnail: "image"),
        MealEntity(id: "1235", name: "meat2", thumbnail: "image2"),
      ],
      mealId: "1234",
    );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<FoodDetailsCubit>.value(
            value: mockFoodDetailsCubit
              ..doIntent(
                intent: FoodDetailsInitializationIntent(
                  foodDetailsArgument: foodDetailsArgument,
                ),
              ),
            child: const CustomScrollView(slivers: [FoodIngredientsSection()]),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodIngredientsSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.text(AppText.ingredients.tr()), findsOneWidget);
    expect(find.text(AppText.recommendation.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(
      find.byType(BlocBuilder<FoodDetailsCubit, FoodDetailsState>),
      findsWidgets,
    );
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(FoodIngredientItem), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
