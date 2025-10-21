import 'package:fitness_app/utils/common_widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view_body.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';

class FitnessBottomNavigationView extends StatelessWidget {
  const FitnessBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FitnessBottomNavigationCubit(),
      child: const Scaffold(
        body: FitnessBottomNavigationViewBody(),
        bottomNavigationBar: FitnessBottomNavigationBar(),
      ),
    );
  }
}
