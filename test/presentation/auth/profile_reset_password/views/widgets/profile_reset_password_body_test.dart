import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
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

@GenerateMocks([ProfileResetPasswordCubit])
void main() async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  provideDummy<ProfileResetPasswordState>(
    const ProfileResetPasswordState(
      profileResetPasswordState: StateStatus.initial(),
      isObscure: true,
    ),
  );

  late MockProfileResetPasswordCubit mockCubit;
  const initialState = ProfileResetPasswordState(
    profileResetPasswordState: StateStatus.initial(),
    isObscure: true,
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
            body: BlocProvider<ProfileResetPasswordCubit>.value(
              value: mockCubit,
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
        isObscure: true,
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
}
