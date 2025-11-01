import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/food_details_argument/food_details_argument.dart';
import 'package:fitness_app/domain/entities/meals/meals_entity.dart';
import 'package:fitness_app/presentation/food_details/views/food_details_view.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/food_details_view_body.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_cubit.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_intent.dart';
import 'package:fitness_app/presentation/food_details/views_model/food_details_state.dart';
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
  late MockFoodDetailsCubit mockFoodDetailsCubit;
  setUp(() {
    mockFoodDetailsCubit = MockFoodDetailsCubit();
    getIt.registerFactory<FoodDetailsCubit>(() => mockFoodDetailsCubit);
    provideDummy<FoodDetailsState>(const FoodDetailsState());
    when(mockFoodDetailsCubit.state).thenReturn(const FoodDetailsState());
    when(
      mockFoodDetailsCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const FoodDetailsState()]));
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
            child: FoodDetailsView(foodDetailsArgument: foodDetailsArgument),
          ),
        );
      },
    );
  }

  testWidgets("Verifying FoodDetailsView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<FoodDetailsCubit>), findsAny);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is Scaffold,
      ),
      findsOneWidget,
    );
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(FoodDetailsViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
