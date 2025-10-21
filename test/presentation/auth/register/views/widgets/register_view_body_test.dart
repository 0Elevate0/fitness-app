import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_account_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_app_bar.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_view_body.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_view_body_test.mocks.dart';

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
            child: const Scaffold(body: RegisterViewBody()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RegisterViewBody Widgets on Initial State", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 2 &&
            widget.children.first is RegisterAppBar,
      ),
      findsOneWidget,
    );
    expect(find.byType(BlocBuilder<RegisterCubit, RegisterState>), findsAny);
    expect(find.byType(RegisterAccountSection), findsOneWidget);
    expect(find.byType(GenderSection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Gender State", (
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
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
