import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_avatar.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_items_list.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_view_body.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_body_test.mocks.dart';

@GenerateMocks([ProfileCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockProfileCubit mockProfileCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<ProfileCubit>(() => mockProfileCubit);
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<ProfileState>(const ProfileState());
    when(mockProfileCubit.state).thenReturn(const ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ProfileState()]));

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
              BlocProvider<ProfileCubit>.value(value: mockProfileCubit),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const Scaffold(body: ProfileViewBody()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ProfileViewBody Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlocListener<GlobalCubit, GlobalState>), findsWidgets);
    expect(find.byType(BlocBuilder<GlobalCubit, GlobalState>), findsWidgets);
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Text), findsWidgets);
    expect(find.text(AppText.profile.tr()), findsOneWidget);
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.byType(ProfileAvatar), findsOneWidget);
    expect(find.byType(ProfileItemsList), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
