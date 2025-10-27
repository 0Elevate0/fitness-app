import 'package:fitness_app/presentation/auth/verification/views/widgets/build_blurred_container.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_cubit.dart';
import 'package:fitness_app/presentation/auth/verification/views_model/verification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'build_blurred_container_test.mocks.dart';

 @GenerateMocks([VerificationCubit])
void main() {
  late MockVerificationCubit mockCubit;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockVerificationCubit();

     when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state)
        .thenReturn(const VerificationState(secondsRemaining: 0));
    when(mockCubit.verificationController)
        .thenReturn(TextEditingController());
    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
     when(mockCubit.doIntent(any)).thenReturn(null);
  });

  Widget createWidgetUnderTest({
    required String email,
    required bool isError,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: BlocProvider<VerificationCubit>.value(
            value: mockCubit,
            child: BuildBlurredContainer(
              email: email,
              isError: isError,
            ),
          ),
        ),
      ),
    );
  }


  testWidgets('renders BuildBlurredContainer correctly', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      email: 'test@example.com',
      isError: false,
    ));

    await tester.pump(); // 👈 بدل pumpAndSettle
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(BuildBlurredContainer), findsOneWidget);
  });
}
