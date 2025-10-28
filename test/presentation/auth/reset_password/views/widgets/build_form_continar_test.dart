import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
 import 'package:fitness_app/presentation/auth/reset_password/views/widgets/build_form_continar.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
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

import '../reset_password_view_test.mocks.dart';

@GenerateMocks([ResetPasswordCubit])
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  provideDummy<ResetPasswordState>(
    const ResetPasswordState(
      resetPasswordState: StateStatus.initial(),
      autoValidateMode: AutovalidateMode.disabled,
    ),
  );

  late MockResetPasswordCubit mockCubit;

  const initialState = ResetPasswordState(
    resetPasswordState: StateStatus.initial(),
    autoValidateMode: AutovalidateMode.disabled,
  );

  setUp(() {
    mockCubit = MockResetPasswordCubit();

    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.passwordController).thenReturn(TextEditingController());
    when(mockCubit.confirmPasswordController).thenReturn(TextEditingController());
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'test/assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => MaterialApp(
          home: Scaffold(
            body: BlocProvider<ResetPasswordCubit>.value(
              value: mockCubit,
              child: const BuildFormContainer(email: 'test@email.com'),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders two password fields and a done button', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CustomTextFormField), findsNWidgets(2));
    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(find.byType(CustomElevatedButton), findsOneWidget);
  });

  testWidgets('calls OnDoneClick with correct email and password', (tester) async {
    when(mockCubit.confirmPasswordController)
        .thenReturn(TextEditingController(text: 'newPassword'));

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pump();

    verify(mockCubit.doIntent(argThat(
      isA<OnDoneClick>()
          .having((intent) => intent.request.email, 'email', 'test@email.com')
          .having((intent) => intent.request.newPassword, 'newPassword', 'newPassword'),
    ))).called(1);
  });

  testWidgets('toggles password visibility when icon tapped', (tester) async {
    when(mockCubit.state).thenReturn(
      const ResetPasswordState(isPasswordVisible: false),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final icons = find.byIcon(Icons.visibility);
    await tester.tap(icons.at(0));
    await tester.pump();

    verify(mockCubit.doIntent(argThat(isA<TogglePasswordVisibility>()))).called(1);
  });

  testWidgets('toggles confirm password visibility when icon tapped', (tester) async {
    when(mockCubit.state).thenReturn(
      const ResetPasswordState(isConfirmPasswordVisible: false),
    );

    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.visibility).last);
    await tester.pump();

    verify(mockCubit.doIntent(argThat(isA<ToggleConfirmPasswordVisibility>()))).called(1);
  });
}
