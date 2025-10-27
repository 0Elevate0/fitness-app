import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/widgets/reset_password_body_view.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/widgets/build_reset_password_form.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_body_view_test.mocks.dart';

@GenerateMocks([ResetPasswordCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockResetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockResetPasswordCubit();

    provideDummy<ResetPasswordState>(const ResetPasswordState());

    when(mockCubit.state).thenReturn(const ResetPasswordState());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget(String email) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'test/assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: Scaffold(
            body: BlocProvider<ResetPasswordCubit>.value(
              value: mockCubit,
              child: ResetPasswordBodyView(email: email),
            ),
          ),
          routes: {
            RouteNames.login: (context) => const Scaffold(body: Text('Login')),
          },
        ),
      ),
    );
  }

  testWidgets('renders BuildResetPasswordForm with correct email', (
    tester,
  ) async {
    const testEmail = 'test@example.com';

    await tester.pumpWidget(buildTestableWidget(testEmail));
    await tester.pumpAndSettle();

    final formFinder = find.byType(BuildResetPasswordForm);
    expect(formFinder, findsOneWidget);

    final formWidget = tester.widget<BuildResetPasswordForm>(formFinder);
    expect(formWidget.email, testEmail);
  });

  testWidgets('shows loading dialog when state is loading', (tester) async {
    const testEmail = 'test@example.com';

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ResetPasswordState(),
        const ResetPasswordState(resetPasswordState: StateStatus.loading()),
      ]),
    );

    await tester.pumpWidget(buildTestableWidget(testEmail));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('navigates to login on success', (tester) async {
    const testEmail = 'test@example.com';

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ResetPasswordState(),
        const ResetPasswordState(resetPasswordState: StateStatus.success(null)),
      ]),
    );

    await tester.pumpWidget(buildTestableWidget(testEmail));
    await tester.pumpAndSettle();

    // Navigator.pushReplacementNamed
    expect(find.text('Login'), findsOneWidget);

    // Loaders.showSuccessMessage called → we can't verify directly
    // but we can verify it was called by checking Flushbar appears
    expect(find.byType(Flushbar), findsOneWidget);
  });

  testWidgets('shows error message on failure', (tester) async {
    const testEmail = 'test@example.com';
    final error = const ResponseException(message: 'Test error');

    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ResetPasswordState(),
        ResetPasswordState(resetPasswordState: StateStatus.failure(error)),
      ]),
    );

    await tester.pumpWidget(buildTestableWidget(testEmail));
    await tester.pumpAndSettle();

    final flushbarFinder = find.byType(Flushbar);
    expect(flushbarFinder, findsOneWidget);

    final flushbar = tester.widget<Flushbar>(flushbarFinder);
    expect(flushbar.backgroundColor, equals(Colors.red));
  });
}
