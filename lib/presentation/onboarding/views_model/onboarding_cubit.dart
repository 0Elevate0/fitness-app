import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  Future<void> doIntent({required OnboardingIntent intent}) async {
    switch (intent) {
      case ChangePageIntent():
        _updateCurrentPageIndex(index: intent.pageIndex);
        break;
    }
  }

  void _updateCurrentPageIndex({required int index}) {
    emit(state.copyWith(currentPageIndex: index));
  }
}
