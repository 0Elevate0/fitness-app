import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/presentation/home/views/widgets/meal_recommendation_item.dart';
import 'package:fitness_app/presentation/home/views/widgets/meals_recommendation_list.dart';
import 'package:fitness_app/presentation/home/views/widgets/shimmer/recommendation_list_shimmer.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meals_recommendation_list_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: const MealsRecommendationList(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying MealsRecommendationList Widgets on Initial state", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(find.byType(RecommendationListShimmer), findsOneWidget);
  });

  testWidgets("Verifying MealsRecommendationList Widgets on Success state With data", (
    tester,
  ) async {
    // Arrange
    when(mockHomeCubit.state).thenReturn(
      const HomeState(
        mealsCategoriesStatus: StateStatus.success([
          MealCategoryEntity(
            idCategory: "1",
            strCategory: "Beef",
            strCategoryThumb:
                "https://www.themealdb.com/images/category/beef.png",
            strCategoryDescription:
                "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
          ),
          MealCategoryEntity(
            idCategory: "2",
            strCategory: "Chicken",
            strCategoryThumb:
                "https://www.themealdb.com/images/category/chicken.png",
            strCategoryDescription:
                "Chicken is one of the most common types of poultry in the world, known for its versatility in cooking.",
          ),
        ]),
      ),
    );
    when(mockHomeCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const HomeState(
          mealsCategoriesStatus: StateStatus.success([
            MealCategoryEntity(
              idCategory: "1",
              strCategory: "Beef",
              strCategoryThumb:
                  "https://www.themealdb.com/images/category/beef.png",
              strCategoryDescription:
                  "Beef is the culinary name for meat from cattle, particularly skeletal muscle.",
            ),
            MealCategoryEntity(
              idCategory: "2",
              strCategory: "Chicken",
              strCategoryThumb:
                  "https://www.themealdb.com/images/category/chicken.png",
              strCategoryDescription:
                  "Chicken is one of the most common types of poultry in the world, known for its versatility in cooking.",
            ),
          ]),
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.height == 104,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MealRecommendationItem), findsWidgets);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is RSizedBox && widget.width == 16,
      ),
      findsWidgets,
    );
  });

  testWidgets(
    "Verifying MealsRecommendationList Widgets on Success state Without data",
    (tester) async {
      // Arrange
      when(mockHomeCubit.state).thenReturn(
        const HomeState(mealsCategoriesStatus: StateStatus.success([])),
      );
      when(mockHomeCubit.stream).thenAnswer(
        (_) => Stream.fromIterable([
          const HomeState(mealsCategoriesStatus: StateStatus.success([])),
        ]),
      );
      // Act
      await tester.pumpWidget(prepareWidget());
      // Assert
      expect(find.byType(BlocBuilder<HomeCubit, HomeState>), findsOneWidget);

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(
        find.text(AppText.emptyMealRecommendationMessage.tr()),
        findsOneWidget,
      );
    },
  );

  tearDown(() {
    getIt.reset();
  });
}
