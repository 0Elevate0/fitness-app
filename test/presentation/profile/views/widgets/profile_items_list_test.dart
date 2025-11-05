import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_items_list.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_selection_item.dart';
import 'package:fitness_app/presentation/profile/views/widgets/select_language_item.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_items_list_test.mocks.dart';

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

  // Arrange
  Widget prepareWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<GlobalCubit>.value(
            value: mockGlobalCubit,
            child: const Scaffold(body: ProfileItemsList()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying ProfileItemsList Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlurredContainer), findsOneWidget);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(RPadding), findsOneWidget);
    expect(find.byType(ProfileSelectionItem), findsNWidgets(7));
    expect(find.byType(SelectLanguageItem), findsOneWidget);
  });

  tearDown(() {
    getIt.reset();
  });
}
