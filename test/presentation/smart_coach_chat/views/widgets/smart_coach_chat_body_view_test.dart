import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_section.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/smart_coach_chat_app_bar.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/smart_coach_chat_body_view.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'smart_coach_chat_body_view_test.mocks.dart';

@GenerateMocks([SmartCoachChatCubit, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSmartCoachChatCubit mockSmartCoachChatCubit;
  late MockGlobalCubit mockGlobalCubit;
  setUp(() {
    mockSmartCoachChatCubit = MockSmartCoachChatCubit();
    getIt.registerFactory<SmartCoachChatCubit>(() => mockSmartCoachChatCubit);
    provideDummy<SmartCoachChatState>(const SmartCoachChatState());
    when(mockSmartCoachChatCubit.state).thenReturn(const SmartCoachChatState());
    when(
      mockSmartCoachChatCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const SmartCoachChatState()]));
    when(
      mockSmartCoachChatCubit.scaffoldKey,
    ).thenReturn(GlobalKey<ScaffoldState>());
    when(
      mockSmartCoachChatCubit.messageController,
    ).thenReturn(TextEditingController());

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
              BlocProvider<SmartCoachChatCubit>.value(
                value: mockSmartCoachChatCubit
                  ..doIntent(const InitSmartCoachChat()),
              ),
              BlocProvider<GlobalCubit>.value(value: mockGlobalCubit),
            ],
            child: const Scaffold(body: SmartCoachChatBodyView()),
          ),
        );
      },
    );
  }

  testWidgets("Verifying SmartCoachChatBodyView Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget());
    // Assert
    expect(find.byType(BlurredLayerView), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(RSizedBox), findsWidgets);
    expect(find.byType(SmartCoachChatAppBar), findsOneWidget);
    expect(find.byType(Expanded), findsWidgets);
    expect(
      find.byType(BlocBuilder<SmartCoachChatCubit, SmartCoachChatState>),
      findsNWidgets(2),
    );
    expect(find.byType(ChatSection), findsOneWidget);
    expect(find.byType(RPadding), findsNWidgets(2));
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(Icon), findsNWidgets(2));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is GestureDetector && widget.child is Icon,
      ),
      findsOneWidget,
    );
  });

  tearDown(() {
    getIt.reset();
  });
}
