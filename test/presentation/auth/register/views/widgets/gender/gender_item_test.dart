import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_item.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gender_item_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockRegisterCubit;
  setUp(() {
    mockRegisterCubit = MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockRegisterCubit);
    provideDummy<RegisterState>(const RegisterState());
    when(mockRegisterCubit.state).thenReturn(const RegisterState());
    when(
      mockRegisterCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));
    when(mockRegisterCubit.registerFormKey).thenReturn(GlobalKey<FormState>());
    when(
      mockRegisterCubit.firstNameController,
    ).thenReturn(TextEditingController());
    when(
      mockRegisterCubit.lastNameController,
    ).thenReturn(TextEditingController());
    when(mockRegisterCubit.emailController).thenReturn(TextEditingController());
    when(
      mockRegisterCubit.passwordController,
    ).thenReturn(TextEditingController());
  });

  // Arrange
  Widget prepareWidget({
    required Gender? selectedGender,
    required String genderTitle,
    required String genderIcon,
  }) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<RegisterCubit>.value(
            value: mockRegisterCubit
              ..doIntent(intent: const RegisterInitializationIntent()),
            child: const Scaffold(
              body: GenderItem(
                selectedGender: null,
                genderTitle: AppText.male,
                genderIcon: AppIcons.male,
              ),
            ),
          ),
        );
      },
    );
  }

  testWidgets("Verifying GenderItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(
      prepareWidget(
        selectedGender: null,
        genderTitle: AppText.male,
        genderIcon: AppIcons.male,
      ),
    );
    // Assert
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is AnimatedContainer &&
            widget.decoration ==
                BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(width: 1.r, color: AppColors.white),
                ),
      ),
      findsOneWidget,
    );
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(find.byType(FittedBox), findsAny);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(AppText.male.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
