import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/login/views/login_view.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_view_body.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_view_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  late MockLoginCubit mockCubit;
  provideDummy<LoginState>(
    const LoginState(loginStatus: StateStatus.initial(), isObscure: true),
  );

  setUp(() {
    mockCubit = MockLoginCubit();
    when(mockCubit.state).thenReturn(
      const LoginState(
        loginStatus: StateStatus.initial(),
        isObscure: true,
        isValidToLogin: false,
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.loginFormKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController).thenReturn(TextEditingController());
    when(mockCubit.passwordController).thenReturn(TextEditingController());
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: BlocProvider<LoginCubit>.value(
              value: mockCubit,
              child: const LoginView(),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders background image and LoginViewBody', (tester) async {
    // Arrange
    when(
      mockCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});
    getIt.registerFactory<LoginCubit>(() => mockCubit);
    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    // Verify cubit initialization
    verify(mockCubit.doIntent(intent: anyNamed('intent'))).called(1);

    // Check for LoginViewBody
    expect(find.byType(LoginViewBody), findsOneWidget);

    // Check for background image
    final containerFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image != null &&
          ((widget.decoration as BoxDecoration).image!.image as AssetImage)
                  .assetName ==
              AppImages.authBackGround,
    );
    expect(containerFinder, findsOneWidget);
  });
}
