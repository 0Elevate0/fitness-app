import 'package:fitness_app/api/models/onboarding/onboarding_model.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/common_widgets/blured_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingViewBody extends StatefulWidget{


   OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
  PageController pageController=PageController(initialPage: 0);

  int index = 0;

}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return
      PageView.builder(
        onPageChanged: (value){
          widget.index=value;
          setState(() {

          });
        },
        controller:widget.pageController ,
        itemCount:OnBoardingModel.onbourding.length ,
        itemBuilder:(context,index)=> SafeArea(
          child: Column(
          
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed:(){
                        // Navigate to register
                      },
                      child:  Text(
                        AppText.skip,
                        style:theme.textTheme.bodyMedium,
                      ),
                    ),
                ),
                
          SizedBox(height: 50.h,),
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage(OnBoardingModel.onbourding[index].sora),
                width: 900.w,
                height: 900.h,
              ),
            ),
          ),
                SizedBox(height: 10.h,),
          Center(
            child: BlurredContainer(child:Center(child: Column(
            children: [
              Text(OnBoardingModel.onbourding[index].text1,style:theme.textTheme.headlineLarge,),
              SizedBox(height: 10.h,),
            Text(OnBoardingModel.onbourding[index].text2,style: theme.textTheme.bodyLarge,),
              SizedBox(height: 10.h,),
              AnimatedSmoothIndicator(
              activeIndex: index,
              count: OnBoardingModel.onbourding.length,
              effect: ExpandingDotsEffect(
                dotHeight: 10.h,
                dotWidth: 10.w,
                activeDotColor: theme.colorScheme.primary,
                dotColor: theme.colorScheme.outline,
              ),
          
             ),
              SizedBox(height: 20.h,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(visible: index!=0,
                      child:
                    CustomElevatedButton(
                      borderColor: theme.colorScheme.primary,
                        backgroundColor: Colors.transparent,
                        height: 38.h,
                        width: 63.w,
                        onPressed: (){
                        widget.pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
                        }, buttonTitle: AppText.back,titleStyle: theme.textTheme.bodyMedium,)
                    ),
                    Visibility(visible: index==0,
                      child: CustomElevatedButton(
                      height: 40.h,
                      width: 343.w,
                      backgroundColor: theme.colorScheme.primary,
                      borderColor: theme.colorScheme.primary,
                      onPressed: (){
                        widget.pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
                      }, buttonTitle: AppText.next,titleStyle: theme.textTheme.bodyMedium,)),
                    Visibility(visible: index!=0,
                        child: CustomElevatedButton(
                      borderColor: theme.colorScheme.primary,
                      backgroundColor: theme.colorScheme.primary,
                      height: 38.h,
                      width: 63.w,
                      onPressed: (){
                        widget.pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
                      }, buttonTitle: AppText.next,titleStyle: theme.textTheme.bodyMedium,))
                    ],
                ),
              )
          
            ],
            )) ),
          )
              ]),
        ),
      );
  }
}
