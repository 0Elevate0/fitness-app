import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/domain/entities/meal_details/meal_details_entity.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_description_section.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/play_video_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_description_section_test.mocks.dart';

@GenerateMocks([FoodDetailsCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockFoodDetailsCubit mockFoodDetailsCubit;
  late MockGlobalCubit mockGlobalCubit;
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
        ),
      ]),
    );
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
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
          home: MultiBlocProvider(
            providers: [
              BlocProvider<FoodDetailsCubit>.value(
                value: mockFoodDetailsCubit
                  ..doIntent(
                    intent: FoodDetailsInitializationIntent(
                      foodDetailsArgument: foodDetailsArgument,
                    ),
                  ),
              ),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const CustomScrollView(
              slivers: [
                FoodDescriptionSection(
                  mealData: MealDetailsEntity(
                    mealId: "123",
                    mealCategory: "mealCategory",
                    mealTitle: "mealCategory",
                    mealMealThumb: "image",
                    mealInstructions: "mealInstructions",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodDescriptionSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(SliverToBoxAdapter), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(PlayVideoButton), findsOneWidget);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(Flexible), findsWidgets);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
