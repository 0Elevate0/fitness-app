import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_activity/edit_activity_choices.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_activity/edit_activity_section.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_done_button.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_activity_section_test.mocks.dart';

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
    ).thenReturn(EditProfileState(selectedGoal: FitnessMethodHelper.goals[0]));
    when(mockEditProfileCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        EditProfileState(selectedGoal: FitnessMethodHelper.goals[0]),
      ]),
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
            child: const Scaffold(body: EditActivitySection()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying EditActivitySection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    // Assert
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(RPadding), findsWidgets);
    expect(find.byType(FittedBox), findsWidgets);
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(EditActivityChoices), findsOneWidget);
    expect(find.byType(EditDoneButton), findsOneWidget);
    expect(find.text(AppText.activityTitle.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
