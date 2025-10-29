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
  late MockFoodCubit mockFoodCubit;
  provideDummy<FoodState>(const FoodState());


  setUp(() {
    mockFoodCubit = MockFoodCubit();
    when(mockFoodCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockFoodCubit.state).thenReturn(const FoodState());
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) =>
          MaterialApp(
            home: BlocProvider<FoodCubit>.value(
              value: mockFoodCubit,
              child: const Scaffold(body: FoodViewBody()),
            ),
          ),
    );
  }

  testWidgets('renders CategoryList and MealsList', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.byType(CategoryList), findsOneWidget);
    expect(find.byType(MealsList), findsOneWidget);
  });
}
