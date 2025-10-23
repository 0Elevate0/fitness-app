import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/forget_password_button.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/have_an_account_and_register_row.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_form.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/social_media_section.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_form_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  provideDummy<LoginState>(const LoginState());

  const MethodChannel sharedPreferencesChannel = MethodChannel(
    'plugins.flutter.io/shared_preferences',
  );

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(sharedPreferencesChannel, (
        MethodCall methodCall,
      ) async {
        if (methodCall.method == 'getAll') {
          return <String, Object>{}; // empty prefs
        }
        return null;
      });

  await EasyLocalization.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  late MockLoginCubit mockCubit;
  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: BlocProvider<LoginCubit>.value(
            value: mockCubit,
            child: const Scaffold(body: LoginForm()),
          ),
        ),
      ),
    );
  }

  setUp(() {
    mockCubit = MockLoginCubit();

    when(mockCubit.stream).thenAnswer(
      (_) => Stream<LoginState>.value(
        const LoginState(loginStatus: StateStatus.initial(), isObscure: true),
      ),
    );
    when(mockCubit.state).thenReturn(
      const LoginState(loginStatus: StateStatus.initial(), isObscure: true),
    );

    when(mockCubit.loginFormKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController).thenReturn(TextEditingController());
    when(mockCubit.passwordController).thenReturn(TextEditingController());
    when(
      mockCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});
  });

  testWidgets('renders all main widgets correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppText.login.tr()), findsNWidgets(2));
    expect(find.text(AppText.email), findsOneWidget);
    expect(find.text(AppText.password), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);

    expect(find.byType(ForgetPasswordButton), findsOneWidget);
    expect(find.byType(SocialMediaSection), findsOneWidget);
    expect(find.byType(HaveAnAccountAndRegisterRow), findsOneWidget);
  });

  testWidgets('tapping login button triggers cubit.doIntent()', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final loginButtonFinder = find.widgetWithText(
      ElevatedButton,
      AppText.login.tr(),
    );

    expect(loginButtonFinder, findsOneWidget);

    await tester.tap(loginButtonFinder);
    await tester.pump();

    verify(mockCubit.doIntent(intent: anyNamed('intent'))).called(1);
  });
}
