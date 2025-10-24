import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/constants/widget_keys.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_account_section.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/register_account/register_form.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_form_test.mocks.dart';

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
  Widget prepareWidget({Widget? child2}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<RegisterCubit>.value(
            value: mockRegisterCubit
              ..doIntent(intent: const RegisterInitializationIntent()),
            child: Scaffold(
              body: SingleChildScrollView(
                child: child2 ?? const RegisterForm(),
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying RegisterForm Widgets on Initial State", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocBuilder<RegisterCubit, RegisterState>), findsAny);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(3));
    expect(find.byType(CustomTextFormField), findsNWidgets(4));
    expect(find.byType(Text), findsNWidgets(8));
    expect(find.text(AppText.firstName), findsOneWidget);
    expect(find.text(AppText.lastName), findsOneWidget);
    expect(find.text(AppText.email), findsOneWidget);
    expect(find.text(AppText.password), findsOneWidget);
    expect(find.text(AppText.firstNameHint), findsOneWidget);
    expect(find.text(AppText.lastNameHint), findsOneWidget);
    expect(find.text(AppText.emailHint), findsOneWidget);
    expect(find.text(AppText.passwordHint), findsOneWidget);
  });

  testWidgets("Verifying RegisterForm Widgets on form key validation State", (
    tester,
  ) async {
    // Arrange
    when(mockRegisterCubit.doIntent(intent: anyNamed('intent'))).thenAnswer((
      invocation,
    ) {
      final intent = invocation.namedArguments[#intent];
      if (intent is MoveToRegistrationNextStepIntent) {
        // manually trigger validation
        mockRegisterCubit.registerFormKey.currentState?.validate();
      }
      return Future.value();
    });
    // Act
    await tester.pumpWidget(
      prepareWidget(child2: const RegisterAccountSection()),
    );
    await tester.tap(find.byKey(const Key(WidgetKeys.register)));
    await tester.pump();
    // Assert
    expect(find.text(AppText.fieldValidation.tr()), findsNWidgets(2));
    expect(find.text(AppText.emailValidation.tr()), findsOneWidget);
    expect(find.text(AppText.passwordValidation.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
