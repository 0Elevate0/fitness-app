import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/domain/entities/meal_category/meal_category_entity.dart';
import 'package:fitness_app/domain/entities/meals_argument/meals_argument.dart';
import 'package:fitness_app/presentation/food/views/food_view.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_view_body.dart';
import 'package:fitness_app/presentation/food/views_model/food_cubit.dart';
import 'package:fitness_app/presentation/food/views_model/food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_view_test.mocks.dart';

@GenerateMocks([FoodCubit, GlobalCubit])
void main() {
  late MockFoodCubit mockFoodCubit;
  late PageController mockPageController;
  late MockGlobalCubit mockGlobalCubit;
  provideDummy<FoodState>(const FoodState());

  const tCategory = MealCategoryEntity(
    idCategory: '1',
    strCategory: 'Beef',
    strCategoryThumb: 'thumb.jpg',
  );
  const tArgument = MealsArgument(
    selectedCategory: tCategory,
    categories: [tCategory],
  );

  setUp(() {
    mockFoodCubit = MockFoodCubit();
    mockPageController = PageController();
    when(mockFoodCubit.state).thenReturn(const FoodState());
    when(mockFoodCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockFoodCubit.pageController).thenReturn(mockPageController);
    getIt.registerFactory<FoodCubit>(() => mockFoodCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<FoodCubit>.value(value: mockFoodCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const FoodView(argument: tArgument),
          ),
        );
      },
    );
  }

  testWidgets('renders FoodViewBody and background', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.byType(FoodViewBody), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    final image = decoration.image!.image as AssetImage;

    expect(image.assetName, equals(AppImages.homeBackground));
  });

  testWidgets('calls doIntent when created', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    verify(mockFoodCubit.doIntent(intent: anyNamed('intent'))).called(2);
  });

  tearDown(() {
    getIt.reset();
  });
}
