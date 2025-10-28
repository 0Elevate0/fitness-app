import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'onboarding_cubit_test.mocks.dart';

@GenerateMocks([SharedPreferencesHelper, PageController])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockSharedPreferencesHelper mockSharedPreferencesHelper;
  late OnboardingCubit cubit;

  setUpAll(() {
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();
  });

  setUp(() {
    cubit = OnboardingCubit(mockSharedPreferencesHelper);
    cubit.pageController = MockPageController();
  });

  group("OnboardingCubit test", () {
    blocTest<OnboardingCubit, OnboardingState>(
      "on ChangePageIntent emits currentPageIndex with the new value",
      build: () => cubit,
      act: (cubit) async =>
          cubit.doIntent(intent: const ChangePageIntent(pageIndex: 2)),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.currentPageIndex,
          "currentPageIndex is equal to 2",
          equals(2),
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "on NavigateToDotIndexPageIntent emits currentPageIndex with the new value",
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
        intent: const NavigateToDotIndexPageIntent(pageIndex: 1),
      ),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.currentPageIndex,
          "currentPageIndex is equal to 1",
          equals(1),
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "on MoveToNextPageIntent emits currentPageIndex with the next index value",
      build: () {
        when(cubit.pageController.page).thenReturn(1);
        return cubit;
      },
      act: (cubit) async =>
          cubit.doIntent(intent: const MoveToNextPageIntent()),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.currentPageIndex,
          "currentPageIndex is equal to 1",
          equals(1),
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "on MoveToPreviousPageIntent emits currentPageIndex with the previous index value",
      build: () {
        when(cubit.pageController.page).thenReturn(0.0);
        return cubit;
      },
      act: (cubit) async =>
          cubit.doIntent(intent: const MoveToPreviousPageIntent()),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.currentPageIndex,
          "currentPageIndex is equal to 0",
          equals(0),
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "on SkipIntent emits currentPageIndex with the last index",
      build: () {
        when(
          cubit.pageController.page,
        ).thenReturn(cubit.state.onboardingList.length - 1);
        return cubit;
      },
      act: (cubit) async => cubit.doIntent(intent: const SkipIntent()),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.currentPageIndex,
          "currentPageIndex is equal to 0",
          equals(cubit.state.onboardingList.length - 1),
        ),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "on MoveToNextPageIntent with the last index emits isDoIt with true",
      build: () {
        when(cubit.pageController.page).thenReturn(2);
        return cubit;
      },
      act: (cubit) async =>
          cubit.doIntent(intent: const MoveToNextPageIntent()),
      expect: () => [
        isA<OnboardingState>().having(
          (state) => state.isDoIt,
          "isDoIt equal to true",
          equals(true),
        ),
      ],
    );
  });
}
