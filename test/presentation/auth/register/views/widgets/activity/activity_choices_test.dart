import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/activity/activity_choices.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'activity_choices_test.mocks.dart';

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
            child: const Scaffold(body: ActivityChoices()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ActivityChoices Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocProvider<RegisterCubit>), findsOneWidget);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(GoalActivityField), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
