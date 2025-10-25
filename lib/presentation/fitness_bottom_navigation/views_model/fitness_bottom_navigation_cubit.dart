import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FitnessBottomNavigationCubit extends Cubit<FitnessBottomNavigationState> {
  FitnessBottomNavigationCubit() : super(const FitnessBottomNavigationState());

  void doIntent({required FitnessBottomNavigationIntent intent}) {
    switch (intent) {
      case ChangeIndexIntent():
        _changeIndex(index: intent.index);
        break;
    }
  }

  void _changeIndex({required int index}) {
    emit(state.copyWith(currentIndex: index));
  }
}
