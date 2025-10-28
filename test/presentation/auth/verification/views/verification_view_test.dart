 import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/verification/views/verification_view.dart';
import 'package:fitness_app/presentation/auth/verification/views/widgets/verification_view_body.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_intent.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verification_view_test.mocks.dart';

@GenerateMocks([VerificationCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockVerificationCubit mockCubit;

  setUp(() {
    mockCubit = MockVerificationCubit();

    getIt.registerFactory<VerificationCubit>(() => mockCubit);

    provideDummy<VerificationState>(const VerificationState());

    when(mockCubit.state).thenReturn(const VerificationState());
    when(mockCubit.stream).thenAnswer(
          (_) => Stream.fromIterable([const VerificationState()]),
    );

    when(mockCubit.doIntent(any)).thenAnswer((invocation) {
      final intent = invocation.positionalArguments[0];
       if (intent is InitVerificationIntent) {
        when(mockCubit.verificationController).thenReturn(TextEditingController());
        when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
      }
      return;
    });
  });

  Widget prepareWidget(String email) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
           localizationsDelegates: const [],
          supportedLocales: const [Locale('en')],
          home: SingleChildScrollView(
            child: SizedBox(
              height: 812.h,
              child: VerificationView(email: email),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying VerificationView Widgets", (tester) async {
    const testEmail = 'test@example.com';

    await tester.pumpWidget(prepareWidget(testEmail));
    await tester.pump(const Duration(milliseconds: 500)); // بدل pumpAndSettle()

     expect(find.byType(BlocProvider<VerificationCubit>), findsOneWidget);

     expect(
      find.byWidgetPredicate(
            (w) =>
        w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).image != null,
      ),
      findsOneWidget,
    );

     final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.transparent);

     final body =
    tester.widget<VerificationViewBody>(find.byType(VerificationViewBody));
    expect(body.email, testEmail);

     verify(mockCubit.doIntent(any)).called(2);

     expect(mockCubit.formKey, isNotNull);
    expect(mockCubit.verificationController, isNotNull);
  });

  tearDown(() {
    getIt.reset();
  });
}
