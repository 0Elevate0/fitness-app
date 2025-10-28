import 'package:easy_localization/easy_localization.dart';
 import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/build_container.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forget_password_view_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
void main() async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  provideDummy<ForgetPasswordState>(
    const ForgetPasswordState(
      forgetPasswordState: StateStatus.initial(),
      autoValidateMode: AutovalidateMode.disabled,
    ),
  );

  late MockForgetPasswordCubit mockCubit;
  const initialState = ForgetPasswordState(
    forgetPasswordState: StateStatus.initial(),
    autoValidateMode: AutovalidateMode.disabled,
  );

  setUp(() {
    mockCubit = MockForgetPasswordCubit();

    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController).thenReturn(TextEditingController());

    when(mockCubit.doIntent(const InitForgetPasswordFormIntent())).thenAnswer((_) async {});
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'test/assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: BlocProvider<ForgetPasswordCubit>.value(
              value: mockCubit,
              child: const BuildContainer(),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders email field and send button', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.text(AppText.email.tr()), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget); // email icon
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.text(AppText.sendOtp.tr()), findsOneWidget);
  });

  testWidgets('calls OnSendOtpClick with trimmed email on button press', (tester) async {
    // Arrange
    const rawEmail = '  test@example.com  ';
    const trimmedEmail = 'test@example.com';

    when(mockCubit.emailController).thenReturn(TextEditingController(text: rawEmail));

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pump();

    // Assert
    verify(mockCubit.doIntent(argThat(
      isA<OnSendOtpClick>().having(
            (i) => i.request.email,
        'email',
        trimmedEmail,
      ),
    ))).called(1);
  });

  testWidgets('shows validation error when email is invalid', (tester) async {
    // Arrange
    const invalidEmail = 'invalid';

     when(mockCubit.state).thenReturn(const ForgetPasswordState(
      autoValidateMode: AutovalidateMode.always,
    ));

    // Set invalid email
    when(mockCubit.emailController).thenReturn(TextEditingController(text: invalidEmail));

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

     await tester.tap(find.byType(CustomElevatedButton));
    await tester.pumpAndSettle();

     expect(
      find.descendant(
        of: find.byType(CustomTextFormField),
        matching: find.text('email'),
      ),
      findsOneWidget,
    );
  });}