import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_goals_section.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:fitness_app/utils/common_widgets/bracket_text.dart';
import 'package:fitness_app/utils/common_widgets/goal_activity_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_goals_section_test.mocks.dart';

@GenerateMocks([EditProfileCubit, ProfileCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockEditProfileCubit mockEditProfileCubit;
  late MockProfileCubit mockProfileCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockEditProfileCubit = MockEditProfileCubit();
    getIt.registerFactory<EditProfileCubit>(() => mockEditProfileCubit);
    provideDummy<EditProfileState>(const EditProfileState());
    when(mockEditProfileCubit.state).thenReturn(const EditProfileState());
    when(
      mockEditProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const EditProfileState()]));
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

    mockProfileCubit = MockProfileCubit();
    getIt.registerFactory<ProfileCubit>(() => mockProfileCubit);
    provideDummy<ProfileState>(const ProfileState());
    when(mockProfileCubit.state).thenReturn(const ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ProfileState()]));

    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<EditProfileCubit>.value(
                value: mockEditProfileCubit
                  ..doIntent(intent: const EditProfileInitializationIntent()),
              ),
              BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const Scaffold(body: EditProfileGoalsSection()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying EditProfileGoalsSection Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<EditProfileCubit, EditProfileState>),
      findsWidgets,
    );
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(BracketText), findsNWidgets(3));
    expect(find.byType(GoalActivityField), findsNWidgets(3));
    expect(find.byType(Text), findsNWidgets(12));
    expect(find.textContaining(AppText.yourWeight.tr()), findsOneWidget);
    expect(find.textContaining(AppText.yourGoal.tr()), findsOneWidget);
    expect(find.textContaining(AppText.yourActivityLevel.tr()), findsOneWidget);
    expect(find.textContaining(AppText.kg.tr()), findsOneWidget);
    expect(find.text(AppText.tapToEdit.tr()), findsNWidgets(3));
    expect(find.byType(RSizedBox), findsWidgets);
  });

  tearDown(() {
    getIt.reset();
  });
}
