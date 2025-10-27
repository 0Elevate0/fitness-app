import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';

import 'onboarding_cubit_test.mocks.dart';





@GenerateMocks([
  SharedPreferencesHelper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSharedPreferencesHelper mockHelper;
  late PageController pageController;
  late OnboardingCubit cubit;


  setUp(() {
    mockHelper = MockSharedPreferencesHelper();

    pageController = PageController(initialPage: 0);
    cubit = OnboardingCubit(mockHelper);


  });

  tearDown(() {
    pageController.dispose();
  });

  group("OnboardingCubit Tests", () {
    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingInitializationIntent: initializes pageController",
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingInitializationIntent()),
      verify: (cubit) {
        expect(cubit.pageController, isNotNull);
        expect(cubit.pageController, isA<PageController>());
      },
    );


    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingChangePageIntent: emits new current page index",
      setUp: () => cubit.pageController = pageController,
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingChangePageIntent(newPageIndex: 1)),
      expect: () => [
        isA<OnboardingState>().having(
              (state) => state.currentpageindex,
          "currentpageindex is 1",
          equals(1),
        ),
      ],
    );


    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingNavigateToDotIndexPageIntent: jumps to a page and updates index",
      setUp: () {

        final mockPageController = MockPageController();


        when(mockPageController.jumpToPage(any)).thenAnswer((_) {});


        cubit.pageController = mockPageController;
      },
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingNavigateToDotIndexPageIntent(dotIndex: 2)),
      skip: 0,
      expect: () => [
        isA<OnboardingState>().having(
              (state) => state.currentpageindex,
          "currentpageindex is 2",
          equals(2),
        ),
      ],
      verify: (cubit) {

        verify(cubit.pageController.jumpToPage(2)).called(1);


        expect(cubit.state.currentpageindex, equals(2));
      },
    );


    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingMoveToNextPageIntent (Last Page): finishes onboarding and saves to helper",
      setUp: () {
        when(mockHelper.saveBool(
            key: ConstKeys.isOnboardingFinished,
            value: true
        )).thenAnswer((_) async => true);
        final mockPageController = MockPageController();
        when(mockPageController.page).thenReturn(2.0);

        cubit.pageController = mockPageController;
      },
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingMoveToNextPageIntent()),
      expect: () => [
        isA<OnboardingState>().having(
              (state) => state.isdoit,
          "isdoit is true",
          equals(true),
        ),
      ],
      verify: (cubit) {

        verify(mockHelper.saveBool(
          key: ConstKeys.isOnboardingFinished,
          value: true,
        )).called(1);

        verifyNever(cubit.pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        ));
      },
    );


    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingMoveToNextPageIntent (Middle Page): moves to next page and updates index",
      setUp: () {

        final mockPageController = MockPageController();
        when(mockPageController.page).thenReturn(1.0);

        when(mockPageController.nextPage(
          duration: anyNamed('duration'),
          curve: anyNamed('curve'),
        )).thenAnswer((_) async {

        });

        cubit.pageController = mockPageController;
      },
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingMoveToNextPageIntent()),
      verify: (cubit) {
        verify(cubit.pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        )).called(1);
        verifyNever(mockHelper.saveBool(
          key: anyNamed('key'),
          value: anyNamed('value'),
        ));
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingMoveToPreviousPageIntent: moves to previous page and updates index",
      setUp: () {
        final mockPageController = MockPageController();
        when(mockPageController.page).thenReturn(1.0);
        when(mockPageController.previousPage(
          duration: anyNamed('duration'),
          curve: anyNamed('curve'),
        )).thenAnswer((_) async {});

        cubit.pageController = mockPageController;
      },
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingMoveToPreviousPageIntent()),
      verify: (cubit) {
        verify(cubit.pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        )).called(1);
      },
    );


    blocTest<OnboardingCubit, OnboardingState>(
      "OnboardingSkipIntent: jumps to the last page and updates index",
      setUp: () {
        final mockPageController = MockPageController();
        when(mockPageController.jumpToPage(any)).thenAnswer((_) {});

        cubit.pageController = mockPageController;
      },
      build: () => cubit,
      act: (cubit) async => cubit.doIntent(
          intent: const OnboardingSkipIntent()),
      skip: 0,
      expect: () => [
        isA<OnboardingState>().having(
              (state) => state.currentpageindex,
          "currentpageindex is last index",
          equals(OnboardingState.onbourding.length - 1),
        ),
      ],
      verify: (cubit) {
        verify(cubit.pageController.jumpToPage(OnboardingState.onbourding.length - 1)).called(1);
      },
    );
  });
}
