import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(" FitnessBottomNavigationCubit Test", () {
    late FitnessBottomNavigationCubit cubit;

    setUp(() {
      cubit = FitnessBottomNavigationCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test("Initial state should be selectedIndex = 0", () {
      expect(cubit.state, const FitnessBottomNavigationState(selectedIndex: 0));
    });

    blocTest<FitnessBottomNavigationCubit, FitnessBottomNavigationState>(
      'emits [selectedIndex = 1] when FitnessBottomNavigationIntent(1) is called',
      build: () => FitnessBottomNavigationCubit(),
      act: (cubit) => cubit.onIntent( FitnessBottomNavigationIntent(1)),
      expect: () => [const FitnessBottomNavigationState(selectedIndex: 1)],
    );

    blocTest<FitnessBottomNavigationCubit, FitnessBottomNavigationState>(
      'emits [selectedIndex = 3] when FitnessBottomNavigationIntent(3) is called',
      build: () => FitnessBottomNavigationCubit(),
      act: (cubit) => cubit.onIntent( FitnessBottomNavigationIntent(3)),
      expect: () => [const FitnessBottomNavigationState(selectedIndex: 3)],
    );

    blocTest<FitnessBottomNavigationCubit, FitnessBottomNavigationState>(
      'does not emit new state when invalid intent is provided',
      build: () => FitnessBottomNavigationCubit(),
      act: (cubit) => cubit.onIntent(FakeIntent()),
      expect: () => [],
    );
  });
}

class FakeIntent extends HomeNavIntent {}
