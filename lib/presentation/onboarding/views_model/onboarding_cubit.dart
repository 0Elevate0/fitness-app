import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final SharedPreferencesHelper _sharedPreferencesHelper;
  OnboardingCubit(this._sharedPreferencesHelper)
    : super(const OnboardingState());
  late final PageController pageController;

  Future<void> doIntent({required OnboardingIntent intent}) async {
    switch (intent) {
      case OnboardingInitializationIntent():
        _onInit();
        break;
      case ChangePageIntent():
        _updateCurrentPageIndex(index: intent.pageIndex);
        break;
      case NavigateToDotIndexPageIntent():
        _navigateToDotIndexPage(index: intent.pageIndex);
        break;
      case MoveToNextPageIntent():
        await _moveToNextPage();
        break;
      case MoveToPreviousPageIntent():
        _moveToPreviousPage();
        break;
      case SkipIntent():
        _skipToLastPage();
        break;
    }
  }

  void _onInit() {
    pageController = PageController();
  }

  void _updateCurrentPageIndex({required int index}) {
    emit(state.copyWith(currentPageIndex: index));
  }

  void _navigateToDotIndexPage({required int index}) {
    pageController.jumpToPage(index);
    _updateCurrentPageIndex(index: index);
  }

  Future<void> _moveToNextPage() async {
    if (pageController.page == 2) {
      await _finishedOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
      _updateCurrentPageIndex(index: pageController.page?.toInt() ?? 0);
    }
  }

  void _moveToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    _updateCurrentPageIndex(index: pageController.page?.toInt() ?? 0);
  }

  void _skipToLastPage() {
    pageController.jumpToPage(state.onboardingList.length - 1);
    _updateCurrentPageIndex(index: state.onboardingList.length - 1);
  }

  Future<void> _finishedOnboarding() async {
    await _sharedPreferencesHelper.saveBool(
      key: ConstKeys.isOnboardingFinished,
      value: true,
    );
    emit(state.copyWith(isDoIt: true));
  }
}
