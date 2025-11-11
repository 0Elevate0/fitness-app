import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FitnessBottomNavigationViewBody extends StatelessWidget {
  const FitnessBottomNavigationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      FitnessBottomNavigationCubit,
      FitnessBottomNavigationState
    >(builder: (context, state) => state.taps[state.currentIndex]);
  }
}
