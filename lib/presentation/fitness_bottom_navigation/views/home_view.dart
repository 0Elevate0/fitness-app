
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => FitnessBottomNavigationCubit(),
      child: BlocBuilder<FitnessBottomNavigationCubit, FitnessBottomNavigationState>(
        builder: (context, state) {
          return const Scaffold(
            body:
               FitnessBottomNavigationView());
        },
      ),
    );
  }
}
