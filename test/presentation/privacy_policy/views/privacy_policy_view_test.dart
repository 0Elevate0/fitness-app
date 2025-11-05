import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/privacy_policy/views/privacy_policy_view.dart';
import 'package:fitness_app/presentation/privacy_policy/views/widgets/privacy_policy_view_body.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_cubit.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_view_test.mocks.dart';

@GenerateMocks([PrivacyPolicyCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPrivacyPolicyCubit mockPrivacyPolicyCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockPrivacyPolicyCubit = MockPrivacyPolicyCubit();
    getIt.registerFactory<PrivacyPolicyCubit>(() => mockPrivacyPolicyCubit);
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<PrivacyPolicyState>(const PrivacyPolicyState());
    when(mockPrivacyPolicyCubit.state).thenReturn(const PrivacyPolicyState());
    when(
      mockPrivacyPolicyCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const PrivacyPolicyState()]));

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
              BlocProvider<PrivacyPolicyCubit>.value(
                value: mockPrivacyPolicyCubit,
              ),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const PrivacyPolicyView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying PrivacyPolicyView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<PrivacyPolicyCubit>), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(PrivacyPolicyViewBody), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
