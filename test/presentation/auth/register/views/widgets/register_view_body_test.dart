import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/activity/activity_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/goal/goal_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/height/height_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/old/old_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_account_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_app_bar.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_view_body.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/weight/weight_section.dart';
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

@GenerateMocks([RegisterCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockRegisterCubit;
  late MockGlobalCubit mockGlobalCubit;
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
          home: MultiBlocProvider(
            providers: [
              BlocProvider<RegisterCubit>.value(
                value: mockRegisterCubit
                  ..doIntent(intent: const RegisterInitializationIntent()),
              ),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
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
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsOneWidget);
    expect(find.byType(OldSection), findsNothing);
    expect(find.byType(WeightSection), findsNothing);
    expect(find.byType(HeightSection), findsNothing);
    expect(find.byType(GoalSection), findsNothing);
    expect(find.byType(ActivitySection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Old State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(currentRegistrationProcess: RegistrationProcess.old),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.old,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsNothing);
    expect(find.byType(OldSection), findsOneWidget);
    expect(find.byType(WeightSection), findsNothing);
    expect(find.byType(HeightSection), findsNothing);
    expect(find.byType(GoalSection), findsNothing);
    expect(find.byType(ActivitySection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Weight State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(
        currentRegistrationProcess: RegistrationProcess.weight,
      ),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.weight,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsNothing);
    expect(find.byType(OldSection), findsNothing);
    expect(find.byType(WeightSection), findsOneWidget);
    expect(find.byType(HeightSection), findsNothing);
    expect(find.byType(GoalSection), findsNothing);
    expect(find.byType(ActivitySection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Height State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(
        currentRegistrationProcess: RegistrationProcess.height,
      ),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.height,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsNothing);
    expect(find.byType(OldSection), findsNothing);
    expect(find.byType(WeightSection), findsNothing);
    expect(find.byType(HeightSection), findsOneWidget);
    expect(find.byType(GoalSection), findsNothing);
    expect(find.byType(ActivitySection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Goal State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(currentRegistrationProcess: RegistrationProcess.goal),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.goal,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsNothing);
    expect(find.byType(OldSection), findsNothing);
    expect(find.byType(WeightSection), findsNothing);
    expect(find.byType(HeightSection), findsNothing);
    expect(find.byType(GoalSection), findsOneWidget);
    expect(find.byType(ActivitySection), findsNothing);
  });

  testWidgets("Verifying RegisterViewBody Widgets on Activity State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.state).thenReturn(
      const RegisterState(
        currentRegistrationProcess: RegistrationProcess.physical,
      ),
    );
    when(mockRegisterCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(
          currentRegistrationProcess: RegistrationProcess.physical,
        ),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(RegisterAccountSection), findsNothing);
    expect(find.byType(GenderSection), findsNothing);
    expect(find.byType(OldSection), findsNothing);
    expect(find.byType(WeightSection), findsNothing);
    expect(find.byType(HeightSection), findsNothing);
    expect(find.byType(GoalSection), findsNothing);
    expect(find.byType(ActivitySection), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
