import 'package:fitness_app/core/cache/shared_preferences_helper.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable

class OnboardingCubit extends Cubit<OnboardingState> {
 final SharedPreferencesHelper _Helper;
 @factoryMethod
 OnboardingCubit(this._Helper)
     : super(const OnboardingState());
 late final PageController pageController;
 Future<void>doIntent({required OnboardingIntent intent})async{
  switch(intent){
   case OnboardingInitializationIntent():
      _onInit();
     break;
    case OnboardingChangePageIntent():
      _updateCurrentPageIndex(newPageIndex: intent.newPageIndex);
      break;
    case OnboardingNavigateToDotIndexPageIntent():
      _navigateToDotIndexPage(dotIndex: intent.dotIndex);
      break;
    case OnboardingMoveToNextPageIntent():
      await _moveToNextPage();
      break;
    case OnboardingMoveToPreviousPageIntent():
       _moveToPreviousPage();
       break;
    case OnboardingSkipIntent():
      _skipToLastPage();
      break;
  }
 }
 void _onInit() {
  pageController=PageController();
 }
 void _updateCurrentPageIndex({required int newPageIndex}) {
  emit(state.copyWith(currentpageindex: newPageIndex));
 }
 void _navigateToDotIndexPage({required int dotIndex}) {
  pageController.jumpToPage(dotIndex);
  _updateCurrentPageIndex(newPageIndex: dotIndex);
 }
 void _moveToPreviousPage() {
   pageController.previousPage(
     duration: const Duration(milliseconds: 400),
     curve: Curves.easeOut,
   );
   _updateCurrentPageIndex(newPageIndex:pageController.page?.toInt() ?? 0);
 }
 Future<void> _moveToNextPage() async {
   if (pageController.page == 2) {
     await _finishedOnboarding();
   } else {
     pageController.nextPage(
       duration: const Duration(milliseconds: 400),
       curve: Curves.easeIn,
     );
     _updateCurrentPageIndex(newPageIndex: pageController.page?.toInt() ?? 0);
   }
 }

 void _skipToLastPage() {
   pageController.jumpToPage(OnboardingState.onbourding.length - 1);
   _updateCurrentPageIndex(newPageIndex:  OnboardingState.onbourding.length - 1);
 }

 Future<void> _finishedOnboarding() async {
   await _Helper.saveBool(
     key: ConstKeys.isOnboardingFinished,
     value: true,
   );
   emit(state.copyWith(isdoit: true));
 }
}