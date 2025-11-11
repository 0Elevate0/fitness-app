import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/food/views/widgets/food_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_app_bar_test.mocks.dart';

@GenerateMocks([GlobalCubit])
void main() {
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
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<GlobalCubit>.value(
            value: mockGlobalCubit,
            child: const Scaffold(appBar: FoodAppBar()),
          ),
        ),
      ),
    );
  }

  testWidgets('renders FoodAppBar with correct title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle();

    // Check that the CustomAppBar is present
    expect(find.byType(CustomAppBar), findsOneWidget);

    // Check that the title text is present
    expect(find.text(AppText.foodRecommendation.tr()), findsOneWidget);
  });

  testWidgets('preferredSize is correct', (WidgetTester tester) async {
    const appBar = FoodAppBar();
    expect(appBar.preferredSize.height, 96);
  });

  tearDown(() {
    getIt.reset();
  });
}
