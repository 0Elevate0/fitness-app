import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/build_container.dart';
import 'package:fitness_app/presentation/auth/forget_password/views/widgets/forget_password_body_view.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forget_password_body_view_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit, GlobalCubit])
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
  late MockGlobalCubit mockGlobalCubit;
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

    when(
      mockCubit.doIntent(const InitForgetPasswordFormIntent()),
    ).thenAnswer((_) async {});

    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'test/assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ForgetPasswordCubit>.value(value: mockCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const Scaffold(body: ForgetPasswordBodyView()),
          ),
        ),
      ),
    );
  }

  testWidgets('renders all child widgets in initial state', (tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(
      find.image(const AssetImage(AppImages.superFitness)),
      findsOneWidget,
    );
    expect(find.text(AppText.enterYourEmail.tr()), findsOneWidget);
    expect(find.text(AppText.forgetPassword.tr()), findsOneWidget);
    expect(find.byType(BuildContainer), findsOneWidget);
  });

  testWidgets('shows loading dialog when state is loading', (tester) async {
    final states = [
      initialState,
      const ForgetPasswordState(forgetPasswordState: StateStatus.loading()),
    ];

    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable(states));
    when(mockCubit.state).thenReturn(initialState);

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
