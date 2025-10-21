import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';

class FitnessBottomNavigationViewBody extends StatelessWidget {
  const FitnessBottomNavigationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FitnessBottomNavigationCubit, FitnessBottomNavigationState>(
      builder: (context, state) {
        final pages = [
          const Center(child: Text("Explore Page")),
          const Center(child: Text("Chat Ai Page")),
          const Center(child: Text("Workout Page")),
          const Center(child: Text("Profile Page")),
        ];

        return pages[state.selectedIndex];
      },
    );
  }
}
