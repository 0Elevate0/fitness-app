import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/forget_password_view.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/forget_password_body_view.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_view_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockForgetPasswordCubit mockCubit;
  late MockGlobalCubit mockGlobalCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();

    getIt.registerFactory<ForgetPasswordCubit>(() => mockCubit);

    provideDummy<ForgetPasswordState>(const ForgetPasswordState());

    when(mockCubit.state).thenReturn(const ForgetPasswordState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ForgetPasswordState()]));

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController).thenReturn(TextEditingController());

    when(
      mockCubit.doIntent(const InitForgetPasswordFormIntent()),
    ).thenAnswer((_) => Future.value());

    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);

    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<GlobalCubit>.value(
            value: mockGlobalCubit,
            child: const ForgetPasswordView(),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ForgetPasswordView Widgets", (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    expect(find.byType(BlocProvider<ForgetPasswordCubit>), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Container && widget.child is Scaffold,
      ),
      findsOneWidget,
    );

    expect(find.byType(Scaffold), findsOneWidget);

    expect(find.byType(ForgetPasswordBodyView), findsOneWidget);

    verify(mockCubit.doIntent(const InitForgetPasswordFormIntent())).called(1);
  });

  tearDown(() {
    getIt.reset();
  });
}
