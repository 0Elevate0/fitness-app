import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/security/views/security_view.dart';
import 'package:fitness_app/presentation/security/views/widgets/security_view_body.dart';
import 'package:fitness_app/presentation/security/views_model/security_cubit.dart';
import 'package:fitness_app/presentation/security/views_model/security_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_view_test.mocks.dart';

@GenerateMocks([SecurityCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSecurityCubit mockSecurityCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockSecurityCubit = MockSecurityCubit();
    getIt.registerFactory<SecurityCubit>(() => mockSecurityCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<SecurityState>(const SecurityState());
    when(mockSecurityCubit.state).thenReturn(const SecurityState());
    when(
      mockSecurityCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const SecurityState()]));

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
              BlocProvider<SecurityCubit>.value(value: mockSecurityCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const SecurityView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SecurityView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<SecurityCubit>), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(SecurityViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
