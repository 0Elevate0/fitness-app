import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/onboarding/views/widgets/onboarding_details.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_cubit.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_intent.dart';
import 'package:fitness_app/presentation/onboarding/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key}); // Use 'const' if possible, or leave it as is.

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();

}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardingcubit =BlocProvider.of<OnboardingCubit>(context);
    return BlocListener<OnboardingCubit,OnboardingState>(
      listener: (context,state){
        if(state.isdoit){
          Navigator.of(context).pushReplacementNamed(RouteNames.login);
        }
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
  builder: (context, state) {
    return PageView.builder(
        onPageChanged: (value)=>onboardingcubit.doIntent(intent: OnboardingChangePageIntent(newPageIndex: value)),
        controller: onboardingcubit.pageController,
        itemCount: OnboardingState.onbourding.length,
        itemBuilder: (context, index) => SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: state.currentpageindex!= OnboardingState.onbourding.length -1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () =>onboardingcubit.doIntent(intent:const OnboardingSkipIntent()),
                    child: Text(
                      AppText.skip.tr(),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              const RSizedBox(
                height: 50,
              ),
              Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(OnboardingState.onbourding[index].imagePath),
                    width: 300.w,
                    height: 300.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const RSizedBox(
                height: 10,
              ),
              OnboardingDetails(onboardingEntity: OnboardingState.onbourding[state.currentpageindex])

            ],
          ),
        ),
      );
  },
),
    );
  }
}