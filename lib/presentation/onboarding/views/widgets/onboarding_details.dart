import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDetails extends StatelessWidget {
  final Duration duration = const Duration(milliseconds: 200);
  final OnBoardingEntity onboardingEntity;

  const OnboardingDetails({super.key, required this.onboardingEntity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final OnboardingCubit onboardingcubit = BlocProvider.of<OnboardingCubit>(
        context);
    return BlurredContainer(
        child: Center(
            child: BlocBuilder<OnboardingCubit,OnboardingState>(
              builder: (context, state) =>Column(
                  children: [
                    Text(
                      onboardingEntity.title.tr(),
                      // Use _index
                      style: theme.textTheme.headlineLarge,
                    ),
                    const RSizedBox(
                      height: 10,
                    ),
                    Text(
                      onboardingEntity.subtitle.tr(),
                      // Use _index
                      style: theme.textTheme.bodyLarge,
                    ),
                    const RSizedBox(
                      height: 10,
                    ),
                    SmoothPageIndicator(
                      controller: onboardingcubit.pageController,
                      onDotClicked: (index)=>onboardingcubit.doIntent(intent: OnboardingNavigateToDotIndexPageIntent(dotIndex: index)),
                     // activeIndex: _index, // Use _index
                      count: OnboardingState.onbourding.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 10.h,
                        dotWidth: 10.w,
                        activeDotColor: theme.colorScheme.primary,
                        dotColor: theme.colorScheme.outline,
                      ),
                    ),
                    const RSizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                              visible:state.currentpageindex != 0,
                              child: CustomElevatedButton(
                                borderColor: theme.colorScheme.primary,
                                backgroundColor: Colors.transparent,
                                height: 38.h,
                                width: 63.w,
                                onPressed: () =>onboardingcubit.doIntent(intent: const OnboardingMoveToPreviousPageIntent()),
                                buttonTitle: AppText.back.tr(),
                                titleStyle: theme.textTheme.bodyMedium,
                              )),
                          Visibility(
                              visible: state.currentpageindex == 0,
                              child: CustomElevatedButton(
                                height: 40.h,
                                width: 343.w,
                                backgroundColor: theme.colorScheme.primary,
                                borderColor: theme.colorScheme.primary,
                                onPressed: ()=>onboardingcubit.doIntent(intent: const OnboardingMoveToNextPageIntent()),
                                buttonTitle: AppText.next.tr(),
                                titleStyle: theme.textTheme.bodyMedium,
                              )),
                          Visibility(
                              visible: state.currentpageindex != 0, // Use _index
                              child: CustomElevatedButton(
                                borderColor: theme.colorScheme.primary,
                                backgroundColor: theme.colorScheme.primary,
                                height: 38.h,
                                width: 63.w,
                                onPressed: () =>onboardingcubit.doIntent(intent: const OnboardingMoveToNextPageIntent()),
                                buttonTitle: AppText.next.tr(),
                                titleStyle: theme.textTheme.bodyMedium,
                              ))
                        ],
                      ),
                    )
                  ],
                )

            )));
  }

}

