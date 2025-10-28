import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/home/views/widgets/categories_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/home_app_bar.dart';
import 'package:fitness_app/presentation/home/views/widgets/home_view_body.dart';
import 'package:fitness_app/presentation/home/views/widgets/meals_recommendation_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/recommendation_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/workouts_section.dart';
import 'package:fitness_app/presentation/home/views_model/home_cubit.dart';
import 'package:fitness_app/presentation/home/views_model/home_intent.dart';
import 'package:fitness_app/presentation/home/views_model/home_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_body_test.mocks.dart';

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
            child: const HomeViewBody(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying HomeViewBody Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocListener<HomeCubit, HomeState>), findsWidgets);
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(HomeAppBar), findsOneWidget);
    expect(find.byType(CategoriesSection), findsOneWidget);
    expect(find.byType(RecommendationSection), findsOneWidget);
    expect(find.byType(WorkoutsSection), findsOneWidget);
    expect(find.byType(MealsRecommendationSection), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
