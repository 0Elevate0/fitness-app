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
    _checkWorkoutScreenNavigation(index: index, changedTap: changedTap);
    emit(state.copyWith(currentIndex: index));
  }

  void _checkWorkoutScreenNavigation({required int index, Widget? changedTap}) {
    if (changedTap != null) {
      final tempTaps = List.generate(
        state.taps.length,
        (index) => state.taps[index],
      );
      tempTaps.removeAt(index);
      tempTaps.insert(index, changedTap);
      emit(state.copyWith(currentIndex: index, taps: tempTaps));
      return;
    } else if (index == 2) {
      final tempTaps = List.generate(
        state.taps.length,
        (index) => state.taps[index],
      );
      tempTaps.removeAt(index);
      tempTaps.insert(index, const WorkOutView());
      emit(state.copyWith(currentIndex: index, taps: tempTaps));
      return;
    }
  }
}
