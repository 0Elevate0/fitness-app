import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_progress.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'register_progress_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockRegisterCubit;
  setUp(() {
    mockRegisterCubit = MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockRegisterCubit);
    provideDummy<RegisterState>(const RegisterState());
    when(mockRegisterCubit.state).thenReturn(const RegisterState());
    when(
      mockRegisterCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));
    when(mockRegisterCubit.registerFormKey).thenReturn(GlobalKey<FormState>());
    when(
      mockRegisterCubit.firstNameController,
    ).thenReturn(TextEditingController());
    when(
      mockRegisterCubit.lastNameController,
    ).thenReturn(TextEditingController());
    when(mockRegisterCubit.emailController).thenReturn(TextEditingController());
    when(
      mockRegisterCubit.passwordController,
    ).thenReturn(TextEditingController());
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<RegisterCubit>.value(
            value: mockRegisterCubit
              ..doIntent(intent: const RegisterInitializationIntent()),
            child: const Scaffold(body: RegisterProgress()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RegisterProgress Widgets on Initial State", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<RegisterCubit, RegisterState>),
      findsOneWidget,
    );
    expect(find.byType(Center), findsAny);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CircularPercentIndicator && widget.percent == 0,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Verifying RegisterProgress Widgets on Gender State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(
        currentRegistrationProcess: RegistrationProcess.gender,
      ),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.gender,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is CircularPercentIndicator &&
            widget.percent != 0 &&
            widget.progressColor == Colors.transparent,
      ),
      findsOneWidget,
    );
  });

  tearDown(() {
    getIt.reset();
  });
}
