 import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/reset_password_view.dart';
import 'package:fitness_app/presentation/auth/reset_password/views/widgets/reset_password_body_view.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_cubit.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_intent.dart';
import 'package:fitness_app/presentation/auth/reset_password/views_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_view_test.mocks.dart';

@GenerateMocks([ResetPasswordCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockResetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockResetPasswordCubit();

     getIt.registerFactory<ResetPasswordCubit>(() => mockCubit);

    provideDummy<ResetPasswordState>(const ResetPasswordState());

    when(mockCubit.state).thenReturn(const ResetPasswordState());
    when(mockCubit.stream).thenAnswer(
          (_) => Stream.fromIterable([const ResetPasswordState()]),
    );


    when(mockCubit.doIntent(any)).thenAnswer((invocation) {
      final intent = invocation.positionalArguments[0];
      if (intent is InitResetPasswordFormIntent) {
         when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
        when(mockCubit.passwordController).thenReturn(TextEditingController());
        when(mockCubit.confirmPasswordController).thenReturn(TextEditingController());
        when(mockCubit.state).thenReturn(const ResetPasswordState(
          autoValidateMode: AutovalidateMode.disabled,
        ));
      }
      return;    });
  });

  Widget prepareWidget(String email) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: SingleChildScrollView(
            child: SizedBox(
              height: 812.h,
              child: ResetPasswordView(email: email),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ResetPasswordView Widgets", (tester) async {
    const testEmail = 'test@example.com';

    await tester.pumpWidget(prepareWidget(testEmail));
    await tester.pumpAndSettle();

     expect(find.byType(BlocProvider<ResetPasswordCubit>), findsOneWidget);

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

     final body = tester.widget<ResetPasswordBodyView>(find.byType(ResetPasswordBodyView));
    expect(body.email, testEmail);

     verify(mockCubit.doIntent(any)).called(1);

     expect(mockCubit.formKey, isNotNull);
    expect(mockCubit.passwordController, isNotNull);
    expect(mockCubit.confirmPasswordController, isNotNull);
  });
  tearDown(() {
    getIt.reset();
  });
}