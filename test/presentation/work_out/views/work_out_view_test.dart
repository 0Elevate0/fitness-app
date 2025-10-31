import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_view_body.dart';
import 'package:fitness_app/presentation/work_out/views/work_out_view.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'work_out_view_test.mocks.dart';

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
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<WorkOutCubit>.value(
            value: mockWorkOutCubit,
            child: const WorkOutView(groupArgument: null),
          ), // uses getIt mock
        );
      },
    );
  }

  testWidgets('renders WorkOutViewBody and background', (tester) async {
    when(
      mockWorkOutCubit.doIntent(intent: anyNamed('intent')),
    ).thenAnswer((_) async {});
    getIt.registerFactory<WorkOutCubit>(() => mockWorkOutCubit);

    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(WorkOutViewBody), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    final image = decoration.image!.image as AssetImage;
    expect(image.assetName, equals(AppImages.homeBackground));
  });

  testWidgets('calls doIntent with InitWorkOutIntent when created', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pump();

    verify(mockWorkOutCubit.doIntent(intent: anyNamed('intent'))).called(1);
  });
}
