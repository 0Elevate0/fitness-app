import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FitnessBottomNavigationCubit cubit;

  setUp(() {
    cubit = FitnessBottomNavigationCubit();
  });

  group("FitnessBottomNavigationCubit test", () {
    blocTest(
      "on ChangeIndexIntent emits currentIndex with the value selected",
      build: () => cubit,
      act: (cubit) async =>
          cubit.doIntent(intent: const ChangeIndexIntent(index: 0)),
      expect: () => [
        isA<FitnessBottomNavigationState>().having(
          (state) => state.currentIndex,
          "current selected index  = 0",
          equals(0),
        ),
      ],
    );
    blocTest(
      "on ChangeIndexIntent emits currentIndex with the value selected",
      build: () => cubit,
      act: (cubit) async =>
          cubit.doIntent(intent: const ChangeIndexIntent(index: 1)),
      expect: () => [
        isA<FitnessBottomNavigationState>().having(
          (state) => state.currentIndex,
          "current selected index  = 1",
          equals(1),
        ),
      ],
    );
    blocTest(
      "on ChangeIndexIntent emits currentIndex with the value selected",
      build: () => cubit,
      act: (cubit) async =>
          cubit.doIntent(intent: const ChangeIndexIntent(index: 2)),
      expect: () => [
        isA<FitnessBottomNavigationState>().having(
          (state) => state.currentIndex,
          "current selected index  = 2",
          equals(2),
        ),
      ],
    );
    blocTest(
      "on ChangeIndexIntent emits currentIndex with the value selected",
      build: () => cubit,
      act: (cubit) async =>
          cubit.doIntent(intent: const ChangeIndexIntent(index: 3)),
      expect: () => [
        isA<FitnessBottomNavigationState>().having(
          (state) => state.currentIndex,
          "current selected index  = 3",
          equals(3),
        ),
      ],
    );
  });
}
