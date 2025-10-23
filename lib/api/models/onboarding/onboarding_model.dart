import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';

class OnBoardingModel{
  String sora;
  String text1;
  String text2;
  OnBoardingModel({required this.sora,required this.text1,required this.text2});
  static List<OnBoardingModel>onbourding=[
    OnBoardingModel(sora: AppImages.onboarding1, text1:AppText.onboard1 , text2:AppText.onboardsubtitle),
    OnBoardingModel(sora: AppImages.onboarding2, text1:AppText.onboard2 , text2: AppText.onboardsubtitle),
    OnBoardingModel(sora: AppImages.onboarding3, text1:AppText.onboard3, text2: AppText.onboardsubtitle),
  ];

}