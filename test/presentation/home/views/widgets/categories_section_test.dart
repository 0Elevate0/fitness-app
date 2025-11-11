import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/presentation/home/views/widgets/categories_section.dart';
import 'package:fitness_app/presentation/home/views/widgets/category_item.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_section_test.mocks.dart';

@GenerateMocks([FitnessBottomNavigationCubit])
void main() {
  late MockFitnessBottomNavigationCubit mockFitnessBottomNavigationCubit;
  setUp(() {
    mockFitnessBottomNavigationCubit = MockFitnessBottomNavigationCubit();
    getIt.registerFactory<FitnessBottomNavigationCubit>(
      () => mockFitnessBottomNavigationCubit,
    );
    provideDummy<FitnessBottomNavigationState>(
      const FitnessBottomNavigationState(),
    );
    when(
      mockFitnessBottomNavigationCubit.state,
    ).thenReturn(const FitnessBottomNavigationState());

    when(mockFitnessBottomNavigationCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const FitnessBottomNavigationState()]),
    );
  });
  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<FitnessBottomNavigationCubit>.value(
            value: mockFitnessBottomNavigationCubit,
            child: const CategoriesSection(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying CategoriesSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.text(AppText.category.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is CategoryItem,
      ),
      findsWidgets,
    );
  });
}
