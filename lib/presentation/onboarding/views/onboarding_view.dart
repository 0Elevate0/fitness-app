import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_view_body.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => getIt.get<OnboardingCubit>(),
      child: const Scaffold(body: OnboardingViewBody()),
    );
  }
}
