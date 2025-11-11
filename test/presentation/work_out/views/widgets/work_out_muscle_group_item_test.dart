import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_group_item.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'work_out_muscle_group_item_test.mocks.dart';

@GenerateMocks([WorkOutCubit])
void main() {
  late MockWorkOutCubit mockWorkOutCubit;
  provideDummy<WorkOutState>(const WorkOutState());

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  setUp(() {
    mockWorkOutCubit = MockWorkOutCubit();
    when(mockWorkOutCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockWorkOutCubit.state).thenReturn(const WorkOutState());
  });

  Widget buildTestableWidget({
    required MuscleGroupEntity group,
    required bool isSelected,
  }) {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<WorkOutCubit>.value(
            value: mockWorkOutCubit,
            child: Scaffold(
              body: WorkOutMuscleGroupItem(
                muscleGroupData: group,
                isSelected: isSelected,
              ),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders correctly and calls cubit.doIntent on tap', (
    WidgetTester tester,
  ) async {
    // Arrange
    final group = const MuscleGroupEntity(id: '1', name: 'Chest');
    when(
      mockWorkOutCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});

    await tester.pumpWidget(
      buildTestableWidget(group: group, isSelected: false),
    );

    // Assert initial UI
    expect(find.text('Chest'), findsOneWidget);

    // Act
    await tester.tap(find.byType(WorkOutMuscleGroupItem));
    await tester.pumpAndSettle();

    // Assert
    verify(mockWorkOutCubit.doIntent(intent: anyNamed('intent'))).called(1);
  });

  testWidgets('applies selected style when isSelected is true', (
    WidgetTester tester,
  ) async {
    // Arrange
    final group = const MuscleGroupEntity(id: '2', name: 'Back');

    await tester.pumpWidget(
      buildTestableWidget(group: group, isSelected: true),
    );

    // Assert
    final container = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, isNotNull); // Should have a selected color
  });
}
