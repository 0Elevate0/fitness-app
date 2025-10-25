import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_bar.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views/widgets/fitness_bottom_navigation_view_body.dart';
import 'package:fitness_app/presentation/fitness_bottom_navigation/views_model/fitness_bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FitnessBottomNavigationView extends StatelessWidget {
  const FitnessBottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FitnessBottomNavigationCubit>(
      create: (context) => getIt.get<FitnessBottomNavigationCubit>(),
      child: const Scaffold(
        extendBody: true,
        bottomNavigationBar: FitnessBottomNavigationBar(),
        body: FitnessBottomNavigationViewBody(),
      ),
    );
  }
}
