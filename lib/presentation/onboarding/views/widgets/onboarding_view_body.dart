import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_item.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isDoIt) {
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      },
      child: BlurredLayerView(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => PageView.builder(
            onPageChanged: (value) => onboardingCubit.doIntent(
              intent: ChangePageIntent(pageIndex: value),
            ),
            controller: onboardingCubit.pageController,
            itemBuilder: (context, index) =>
                OnboardingItem(onboardingData: state.onboardingList[index]),
            itemCount: state.onboardingList.length,
          ),
        ),
      ),
    );
  }
}
