import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/loading_button.dart';
import 'package:fitness_app/utils/dialogs/logout_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_dialog_content_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockProfileCubit mockProfileCubit;
  setUp(() {
    mockProfileCubit = MockProfileCubit();
    getIt.registerFactory<ProfileCubit>(() => mockProfileCubit);
    provideDummy<ProfileState>(const ProfileState());
    when(mockProfileCubit.state).thenReturn(const ProfileState());
    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const ProfileState()]));
  });

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<ProfileCubit>.value(
            value: mockProfileCubit,
            child: const Scaffold(body: LogoutDialogContent()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying LogoutDialogContent Widgets on Initial State", (
    tester,
  ) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(FittedBox), findsNWidgets(4));
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Text), findsNWidgets(4));
    expect(
      find.byType(BlocBuilder<ProfileCubit, ProfileState>),
      findsOneWidget,
    );
    expect(find.byType(CustomElevatedButton), findsNWidgets(2));
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.text(AppText.logoutCapital.tr()), findsOneWidget);
    expect(find.text(AppText.confirmLogout.tr()), findsOneWidget);
    expect(find.text(AppText.cancel.tr()), findsOneWidget);
    expect(find.text(AppText.logout.tr()), findsOneWidget);
  });

  testWidgets("Verifying LogoutDialogContent Widgets on Loading State", (
    tester,
  ) async {
    // Arrange
    when(
      mockProfileCubit.state,
    ).thenReturn(const ProfileState(logoutStatus: StateStatus.loading()));
    when(mockProfileCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const ProfileState(logoutStatus: StateStatus.loading()),
      ]),
    );
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(FittedBox), findsNWidgets(3));
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(Text), findsNWidgets(3));
    expect(
      find.byType(BlocBuilder<ProfileCubit, ProfileState>),
      findsOneWidget,
    );
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(LoadingButton), findsOneWidget);
    expect(find.text(AppText.logoutCapital.tr()), findsOneWidget);
    expect(find.text(AppText.confirmLogout.tr()), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
