import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_back_button.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_next_button.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingDetails extends StatelessWidget {
  const OnboardingDetails({super.key, required this.onboardingData});
  final OnboardingEntity onboardingData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardingCubit = BlocProvider.of<OnboardingCubit>(context);
    return PositionedDirectional(
      bottom: 0,
      start: 0,
      end: 0,
      child: BlurredContainer(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 31.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.r),
          topRight: Radius.circular(50.r),
        ),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  onboardingData.title.tr(),
                  key: ValueKey(
                    onboardingData.title,
                  ), // Important for animation
                  style: theme.textTheme.headlineLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const RSizedBox(height: 4),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  onboardingData.subTitle.tr(),
                  key: ValueKey(onboardingData.subTitle),
                  style: theme.textTheme.bodyLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const RSizedBox(height: 24),
              SmoothPageIndicator(
                controller: onboardingCubit.pageController,
                count: state.onboardingList.length,
                onDotClicked: (index) => onboardingCubit.doIntent(
                  intent: NavigateToDotIndexPageIntent(pageIndex: index),
                ),
                effect: ExpandingDotsEffect(
                  dotWidth: 8.r,
                  dotHeight: 8.r,
                  radius: 20.r,
                  strokeWidth: 24.r,
                  activeDotColor: theme.colorScheme.primary,
                  dotColor: theme.colorScheme.onSecondary,
                ),
              ),
              const RSizedBox(height: 24),
              Visibility(
                visible: state.currentPageIndex == 0,
                child: const OnboardingNextButton(),
              ),
              Visibility(
                visible: state.currentPageIndex > 0,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [OnboardingBackButton(), OnboardingNextButton()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
