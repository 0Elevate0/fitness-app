import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_intent.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FitnessBottomNavigationCubit extends Cubit<FitnessBottomNavigationState> {
  FitnessBottomNavigationCubit() : super(const FitnessBottomNavigationState(selectedIndex: 0));

  void onIntent(HomeNavIntent intent) {
    if (intent is FitnessBottomNavigationIntent) {
      emit(state.copyWith(selectedIndex: intent.newIndex));
    }
  }
}
