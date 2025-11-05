import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/help/views/help_view.dart';
import 'package:fitness_app/presentation/help/views/widgets/help_view_body.dart';
import 'package:fitness_app/presentation/help/views_model/help_cubit.dart';
import 'package:fitness_app/presentation/help/views_model/help_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_view_test.mocks.dart';

@GenerateMocks([HelpCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockHelpCubit mockHelpCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockHelpCubit = MockHelpCubit();
    getIt.registerFactory<HelpCubit>(() => mockHelpCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<HelpState>(const HelpState());
    when(mockHelpCubit.state).thenReturn(const HelpState());
    when(
      mockHelpCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HelpState()]));

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
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HelpCubit>.value(value: mockHelpCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const HelpView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying HelpView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<HelpCubit>), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(HelpViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
