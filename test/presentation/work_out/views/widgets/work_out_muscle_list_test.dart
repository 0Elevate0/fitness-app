import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/entities/muscle_group/muscle_group_entity.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/shimmer/muscle_grid_shimmer.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_item.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_list.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'work_out_muscle_list_test.mocks.dart';

@GenerateMocks([WorkOutCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockWorkOutCubit mockCubit;
  provideDummy<WorkOutState>(const WorkOutState());

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockCubit = MockWorkOutCubit();
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state).thenReturn(const WorkOutState());
  });

  Widget buildTestableWidget(WorkOutState state) {
    when(mockCubit.state).thenReturn(state);
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<WorkOutCubit>.value(
            value: mockCubit,
            child: const Scaffold(
              body: WorkOutMuscleList(),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('shows shimmer when loading', (WidgetTester tester) async {
    final state = const WorkOutState(
      musclesByGroupStatus: StateStatus.loading(),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.byType(MusclesGridShimmer), findsOneWidget);
  });

  testWidgets('shows empty message when no muscles', (
    WidgetTester tester,
  ) async {
    final mockGroup = const MuscleGroupEntity(id: '1', name: 'Chest');
    final state = WorkOutState(
      musclesByGroupStatus: const StateStatus.success([]),
      groupArgument: MuscleWithGroupArgument(
        muscleGroup: [mockGroup],
        muscle: const [],
        selectedMuscleGroup: mockGroup,
      ),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.text(AppText.emptyExercisesGroupMessage.tr()), findsOneWidget);
  });

  testWidgets('shows muscle grid when data available', (
    WidgetTester tester,
  ) async {
    final mockGroup = const MuscleGroupEntity(id: '1', name: 'Chest');
    final mockMuscles = [
      const MuscleEntity(id: 'm1', name: 'Push Up'),
      const MuscleEntity(id: 'm2', name: 'Bench Press'),
    ];

    final state = WorkOutState(
      musclesByGroupStatus: StateStatus.success(mockMuscles),
      groupArgument: MuscleWithGroupArgument(
        muscleGroup: [mockGroup],
        muscle: mockMuscles,
        selectedMuscleGroup: mockGroup,
      ),
    );

    await tester.pumpWidget(buildTestableWidget(state));
    await tester.pump();

    expect(find.byType(WorkOutMuscleItem), findsNWidgets(2));
  });
}
