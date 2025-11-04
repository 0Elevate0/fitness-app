import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/profile_reset_password.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_body.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/build_profile_reset_password_form_test.mocks.dart';

@GenerateMocks([ProfileResetPasswordCubit])
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  late MockProfileResetPasswordCubit mockCubit;
  provideDummy<ProfileResetPasswordState>(
    const ProfileResetPasswordState(
      profileResetPasswordState: StateStatus.initial(),
      isObscure: true,
    ),
  );

  setUp(() {
    mockCubit = MockProfileResetPasswordCubit();
    when(mockCubit.state).thenReturn(
      const ProfileResetPasswordState(
        profileResetPasswordState: StateStatus.initial(),
        isObscure: true,
      ),
    );
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
              child: const ProfileResetPassword(),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders background image and ProfileResetPasswordBody', (
    tester,
  ) async {
    // Arrange
    when(mockCubit.doIntent(any)).thenAnswer((_) async {});
    getIt.registerFactory<ProfileResetPasswordCubit>(() => mockCubit);
    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    // Assert
    // Verify cubit initialization
    verify(mockCubit.doIntent(any)).called(1);

    // Check for LoginViewBody
    expect(find.byType(ProfileResetPasswordBody), findsOneWidget);

    // Check for background image (more resilient)
    final containerFinder = find.byWidgetPredicate((widget) {
      if (widget is! Container) return false;
      final decoration = widget.decoration;
      if (decoration is! BoxDecoration) return false;
      final image = decoration.image?.image;
      return image is AssetImage && image.assetName == AppImages.authBackground;
    });
    expect(containerFinder, findsOneWidget);
  });
}
