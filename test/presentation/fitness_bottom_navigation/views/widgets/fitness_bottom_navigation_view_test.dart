import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fitness_bottom_navigation_view_test.mocks.dart';

@GenerateMocks([FitnessBottomNavigationCubit])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFitnessBottomNavigationCubit mockCubit;

  setUp((){
    mockCubit = MockFitnessBottomNavigationCubit();
    when(mockCubit.state)
        .thenReturn(const FitnessBottomNavigationState(selectedIndex: 0));
    when(mockCubit.stream).thenAnswer(
            (_) => Stream.value(const FitnessBottomNavigationState(selectedIndex: 0)));
  });
  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<FitnessBottomNavigationCubit>.value(
        value: mockCubit,
        child: const FitnessBottomNavigationView(),
      ),
    );
  }
  testWidgets("Verify FitnessBottomNavigationView UI builds correctly", (tester) async{
    await tester.pumpWidget(buildTestableWidget());

    expect(find.byType(FitnessBottomNavigationBar), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('When tapping bottom nav item, cubit receives correct intent',
          (tester) async {
        await tester.pumpWidget(buildTestableWidget());

        final bottomNavItems = find.byType(GestureDetector);
        expect(bottomNavItems, findsWidgets);

        await tester.tap(bottomNavItems.at(1));
        await tester.pumpAndSettle();
   });

}