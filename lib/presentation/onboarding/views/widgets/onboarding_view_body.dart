import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key}); // Use 'const' if possible, or leave it as is.

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();

}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late PageController _pageController ;
  int _index = 0;
  final Duration duration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView.builder(
      onPageChanged: (value) {
        setState(() {
          _index = value;
        });
      },
      controller: _pageController,
      itemCount: OnBoardingEntity.onbourding.length,
      itemBuilder: (context, index) => SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to register
                },
                child: Text(
                  AppText.skip.tr(),
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const RSizedBox(
              height: 50,
            ),
            Expanded(
              child: Center(
                child: Image(
                  image: AssetImage(OnBoardingEntity.onbourding[index].imagePath),
                  width: 300.w,
                  height: 300.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const RSizedBox(
              height: 10,
            ),
            Center(
              child: BlurredContainer(
                  child: Center(
                      child: Column(
                        children: [
                          Text(
                            OnBoardingEntity.onbourding[_index].title.tr(), // Use _index
                            style: theme.textTheme.headlineLarge,
                          ),
                          const RSizedBox(
                            height: 10,
                          ),
                          Text(
                            OnBoardingEntity.onbourding[_index].subtitle.tr(), // Use _index
                            style: theme.textTheme.bodyLarge,
                          ),
                          const RSizedBox(
                            height: 10,
                          ),
                          AnimatedSmoothIndicator(
                            activeIndex: _index, // Use _index
                            count: OnBoardingEntity.onbourding.length,
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
                                    visible: _index != 0,
                                    child: CustomElevatedButton(
                                      borderColor: theme.colorScheme.primary,
                                      backgroundColor: Colors.transparent,
                                      height: 38.h,
                                      width: 63.w,
                                      onPressed: () {
                                        _pageController.previousPage(
                                            duration: duration,
                                            curve: Curves.easeInSine);
                                      },
                                      buttonTitle: AppText.back.tr(),
                                      titleStyle: theme.textTheme.bodyMedium,
                                    )),
                                Visibility(
                                    visible: _index == 0,
                                    child: CustomElevatedButton(
                                      height: 40.h,
                                      width: 343.w,
                                      backgroundColor: theme.colorScheme.primary,
                                      borderColor: theme.colorScheme.primary,
                                      onPressed: () {
                                        _pageController.nextPage(
                                            duration: duration,
                                            curve: Curves.easeInSine);
                                      },
                                      buttonTitle: AppText.next.tr(),
                                      titleStyle: theme.textTheme.bodyMedium,
                                    )),
                                Visibility(
                                    visible: _index != 0, // Use _index
                                    child: CustomElevatedButton(
                                      borderColor: theme.colorScheme.primary,
                                      backgroundColor: theme.colorScheme.primary,
                                      height: 38.h,
                                      width: 63.w,
                                      onPressed: () {
                                        _pageController.nextPage(
                                            duration: duration,
                                            curve: Curves.easeInSine);
                                      },
                                      buttonTitle: AppText.next.tr(),
                                      titleStyle: theme.textTheme.bodyMedium,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}