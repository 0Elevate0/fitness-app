import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_app_bar.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscle_list.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_muscles_group_list.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_view_body.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'work_out_view_body_test.mocks.dart';

@GenerateMocks([WorkOutCubit])
void main() {
  late MockWorkOutCubit mockWorkOutCubit;
  provideDummy<WorkOutState>(const WorkOutState());

  setUp(() {
    mockWorkOutCubit = MockWorkOutCubit();
    when(mockWorkOutCubit.state).thenReturn(const WorkOutState());
    when(mockWorkOutCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestableWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        home: BlocProvider<WorkOutCubit>.value(
          value: mockWorkOutCubit,
          child: const Scaffold(body: WorkOutViewBody()),
        ),
      ),
    );
  }

  testWidgets('renders all main workout widgets', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(buildTestableWidget());

    // Assert
    expect(find.byType(WorkOutAppBar), findsOneWidget);
    expect(find.byType(WorkOutMusclesGroupList), findsOneWidget);
    expect(find.byType(WorkOutMuscleList), findsOneWidget);
  });

  testWidgets('shows error message when musclesByGroupStatus is failure', (
    WidgetTester tester,
  ) async {
    // Arrange
    final failureState = const WorkOutState(
      musclesByGroupStatus: StateStatus.failure(
        ResponseException(message: 'fail'),
      ),
    );

    when(mockWorkOutCubit.state).thenReturn(failureState);
    when(
      mockWorkOutCubit.stream,
    ).thenAnswer((_) => Stream<WorkOutState>.fromIterable([failureState]));
    // Act
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();
    // Assert
    expect(find.text('fail'), findsOneWidget);
  });
}
