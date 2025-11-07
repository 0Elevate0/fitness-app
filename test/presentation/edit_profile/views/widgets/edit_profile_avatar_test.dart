import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/edit_profile/views/widgets/edit_profile_avatar.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_avatar_test.mocks.dart';

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
            child: const Scaffold(body: EditProfileAvatar()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying EditProfileAvatar Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(
      find.byType(BlocBuilder<EditProfileCubit, EditProfileState>),
      findsWidgets,
    );
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Stack), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(RSizedBox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
