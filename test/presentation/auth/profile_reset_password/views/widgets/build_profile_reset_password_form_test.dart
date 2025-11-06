import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/build_profile_reset_password_form.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'build_profile_reset_password_form_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordCubit])
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

  late MockProfileResetPasswordCubit mockCubit;
  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: BlocProvider<ProfileResetPasswordCubit>.value(
            value: mockCubit,
            child: const Scaffold(body: BuildProfileResetPasswordForm()),
          ),
        ),
      ),
    );
  }

  setUp(() {
    mockCubit = MockProfileResetPasswordCubit();

    when(mockCubit.stream).thenAnswer(
      (_) => Stream<ProfileResetPasswordState>.value(
        const ProfileResetPasswordState(
          profileResetPasswordState: StateStatus.initial(),
        ),
      ),
    );
    when(mockCubit.state).thenReturn(
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.initial(),
      ),
    );

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(
      mockCubit.currentPasswordController,
    ).thenReturn(TextEditingController());
    when(
      mockCubit.confirmPasswordController,
    ).thenReturn(TextEditingController());
    when(mockCubit.newPasswordController).thenReturn(TextEditingController());
    when(mockCubit.doIntent(any)).thenAnswer((_) async {});
  });

  testWidgets('renders all main widgets correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text(AppText.currentPassword), findsNWidgets(2));
    expect(find.text(AppText.confirmPassword), findsNWidgets(2));
    expect(find.text(AppText.newPassword), findsNWidgets(2));

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('tapping done button triggers cubit.doIntent()', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    final doneButtonFinder = find.widgetWithText(
      ElevatedButton,
      AppText.done.tr(),
    );

    expect(doneButtonFinder, findsOneWidget);

    await tester.tap(doneButtonFinder);
    await tester.pump();

    verify(mockCubit.doIntent(any)).called(1);
  });
}
