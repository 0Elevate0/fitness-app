import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_weight/edit_weight_choice.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numberpicker/numberpicker.dart';

import 'edit_weight_choice_test.mocks.dart';

@GenerateMocks([EditProfileCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockEditProfileCubit mockEditProfileCubit;
  setUp(() {
    mockEditProfileCubit = MockEditProfileCubit();
    getIt.registerFactory<EditProfileCubit>(() => mockEditProfileCubit);
    provideDummy<EditProfileState>(const EditProfileState());
    when(
      mockEditProfileCubit.state,
    ).thenReturn(const EditProfileState(selectedWeight: 85));
    when(mockEditProfileCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const EditProfileState(selectedWeight: 85)]),
    );
    when(
      mockEditProfileCubit.editProfileKey,
    ).thenReturn(GlobalKey<FormState>());
    when(
      mockEditProfileCubit.firstNameController,
    ).thenReturn(TextEditingController());
    when(
      mockEditProfileCubit.lastNameController,
    ).thenReturn(TextEditingController());
    when(
      mockEditProfileCubit.emailController,
    ).thenReturn(TextEditingController());
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<EditProfileCubit>.value(
            value: mockEditProfileCubit
              ..doIntent(intent: const EditProfileInitializationIntent()),
            child: const Scaffold(body: EditWeightChoice()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying EditWeightChoice Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(RSizedBox), findsNWidgets(2));
    expect(
      find.byType(BlocBuilder<EditProfileCubit, EditProfileState>),
      findsOneWidget,
    );
    expect(find.byType(NumberPicker), findsOneWidget);
    expect(find.byType(FittedBox), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.text(AppText.kg.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
