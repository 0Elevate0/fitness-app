import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_details.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_gym_image.dart';
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
    final theme = Theme.of(context);
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isDoIt) {
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      },
      child: BlurredLayerView(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => Stack(
            children: [
              PageView.builder(
                onPageChanged: (value) => onboardingCubit.doIntent(
                  intent: ChangePageIntent(pageIndex: value),
                ),
                controller: onboardingCubit.pageController,
                itemBuilder: (context, index) => OnboardingGymImage(
                  onboardingData: state.onboardingList[index],
                ),
                itemCount: state.onboardingList.length,
              ),
              OnboardingDetails(
                onboardingData: state.onboardingList[state.currentPageIndex],
              ),
              Visibility(
                visible:
                    state.currentPageIndex != state.onboardingList.length - 1,
                child: PositionedDirectional(
                  end: 17,
                  top: 16,
                  child: GestureDetector(
                    onTap: () =>
                        onboardingCubit.doIntent(intent: const SkipIntent()),
                    child: Text(
                      AppText.skip.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
