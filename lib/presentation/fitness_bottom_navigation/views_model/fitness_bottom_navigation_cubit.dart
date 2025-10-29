import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:fitness_app/presentation/work_out/views/work_out_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FitnessBottomNavigationCubit extends Cubit<FitnessBottomNavigationState> {
  FitnessBottomNavigationCubit() : super(const FitnessBottomNavigationState());

  void doIntent({required FitnessBottomNavigationIntent intent}) {
    switch (intent) {
      case ChangeIndexIntent():
        _changeIndex(index: intent.index, changedTap: intent.changedTap);
        break;
    }
  }

  void _changeIndex({required int index, Widget? changedTap}) {
    if (changedTap != null || index == 2) {
      _checkWorkoutScreenNavigation(index: index, changedTap: changedTap);
    } else {
      emit(state.copyWith(currentIndex: index));
    }
  }

  void _checkWorkoutScreenNavigation({required int index, Widget? changedTap}) {
    final Widget? replacementTap =
        changedTap ?? (index == 2 ? const WorkOutView() : null);

    if (replacementTap != null) {
      final tempTaps = List.generate(
        state.taps.length,
        (index) => state.taps[index],
      );
      tempTaps[index] = replacementTap;
      emit(state.copyWith(currentIndex: index, taps: tempTaps));
    }
  }
}
