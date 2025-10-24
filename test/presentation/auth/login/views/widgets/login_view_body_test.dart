import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_form.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/login_view_body.dart';
import 'package:fitness_app/presentation/auth/login/views/widgets/welcome_back_widget.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/login/views_model/login_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_view_body_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  provideDummy<LoginState>(
    const LoginState(loginStatus: StateStatus.initial(), isObscure: true),
  );

  late MockLoginCubit mockCubit;
  const initialState = LoginState(
    loginStatus: StateStatus.initial(),
    isObscure: true,
  );

  setUp(() {
    mockCubit = MockLoginCubit();
    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.loginFormKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.emailController).thenReturn(TextEditingController());
    when(mockCubit.passwordController).thenReturn(TextEditingController());
    when(
      mockCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});
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
              child: const LoginViewBody(),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders all child widgets in initial state', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(WelcomeBackWidget), findsOneWidget);
    expect(find.byType(LoginForm), findsOneWidget);

    // AppBar image
    expect(
      find.image(const AssetImage(AppImages.superFitness)),
      findsOneWidget,
    );
  });

  testWidgets('shows loading dialog when state is loading', (tester) async {
    // Arrange
    final states = [
      initialState,
      const LoginState(loginStatus: StateStatus.loading(), isObscure: true),
    ];

    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable(states));
    when(mockCubit.state).thenReturn(initialState);

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(); // initial build
    await tester.pump(); // process the loading state from the stream

    // Assert
    expect(find.byType(AnimationLoaderWidget), findsOneWidget);
    expect(find.text(AppText.loggingInMessage.tr()), findsOneWidget);
  });
}
