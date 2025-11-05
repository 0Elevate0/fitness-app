import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/auth/profile_reset_password/views/widgets/profile_reset_password_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_reset_password_app_bar_test.mocks.dart';

@GenerateMocks([GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockGlobalCubit = MockGlobalCubit();
    getIt.registerFactory<GlobalCubit>(() => mockGlobalCubit);
    provideDummy<GlobalState>(const GlobalState());
    when(mockGlobalCubit.state).thenReturn(const GlobalState());
    when(
      mockGlobalCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const GlobalState()]));
  });
  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        home: BlocProvider<GlobalCubit>.value(
          value: mockGlobalCubit,
          child: const Scaffold(body: ProfileResetPasswordAppBar()),
        ),
      ),
    );
  }

  testWidgets('renders ProfileResetPasswordAppBar with logo image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(ProfileResetPasswordAppBar), findsOneWidget);

    expect(find.byType(CustomAppBar), findsOneWidget);

    final image = tester.widget<Image>(find.byType(Image));
    final imageProvider = image.image as AssetImage;
    expect(imageProvider.assetName, AppImages.superFitness);
  });

  tearDown(() {
    getIt.reset();
  });
}
