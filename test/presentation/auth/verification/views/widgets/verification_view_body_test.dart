import 'package:fitness_app/presentation/auth/verification/views/widgets/build_verification_form.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/verification_view_body.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'verification_view_body_test.mocks.dart';

@GenerateMocks([VerificationCubit])
void main() {
  late MockVerificationCubit mockCubit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockVerificationCubit();

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state)
        .thenReturn(const VerificationState(secondsRemaining: 0, isError: false));
    when(mockCubit.verificationController)
        .thenReturn(TextEditingController());
    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.doIntent(any)).thenReturn(null);
  });

  Widget createWidgetUnderTest({required String email}) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: BlocProvider<VerificationCubit>.value(
              value: mockCubit,
              child: VerificationViewBody(email: email),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders VerificationViewBody correctly', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(email: 'test@example.com'));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(VerificationViewBody), findsOneWidget);
    expect(find.byType(BuildVerificationForm), findsOneWidget);
  });
}
