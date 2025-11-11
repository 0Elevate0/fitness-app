import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/build_profile_reset_password_form.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/create_new_password_section.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_reset_password_body_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordCubit, GlobalCubit])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGlobalCubit mockGlobalCubit;
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  provideDummy<ProfileResetPasswordState>(
    const ProfileResetPasswordState(
      profileResetPasswordState: StateStatus.initial(),
    ),
  );

  late MockProfileResetPasswordCubit mockCubit;
  const initialState = ProfileResetPasswordState(
    profileResetPasswordState: StateStatus.initial(),
  );

  setUp(() {
    mockCubit = MockProfileResetPasswordCubit();
    when(mockCubit.state).thenReturn(initialState);
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(
      mockCubit.currentPasswordController,
    ).thenReturn(TextEditingController());
    when(
      mockCubit.confirmPasswordController,
    ).thenReturn(TextEditingController());
    when(mockCubit.newPasswordController).thenReturn(TextEditingController());
    when(mockCubit.doIntent(any)).thenAnswer((_) async {});

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
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<ProfileResetPasswordCubit>.value(value: mockCubit),
                BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
              ],
              child: const ProfileResetPasswordBody(),
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
    expect(find.byType(CreateNewPasswordSection), findsOneWidget);
    expect(find.byType(BuildProfileResetPasswordForm), findsOneWidget);

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
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.loading(),
      ),
    ];

    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable(states));
    when(mockCubit.state).thenReturn(initialState);

    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump(); // initial build
    await tester.pump(); // process the loading state from the stream

    // Assert
    expect(find.byType(Dialog), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
