import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/food_details/views/widgets/loading_food_details.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'loading_food_details_test.mocks.dart';

@GenerateMocks([GlobalCubit])
void main() {
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<GlobalCubit>.value(
            value: mockGlobalCubit,
            child: const LoadingFoodDetails(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying LoadingFoodDetails Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(AnimationLoaderWidget), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
