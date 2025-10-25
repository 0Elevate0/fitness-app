import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';

class OnBoardingEntity extends Equatable{
  final String imagePath;
    final String title;
    final String subtitle;
 const OnBoardingEntity({
   required this.imagePath,
   required this.title,
   required this.subtitle});
  static final List<OnBoardingEntity>onbourding=[
   const OnBoardingEntity(imagePath:  AppImages.onboarding1, title:AppText.onboard1 , subtitle:AppText.onboardsubtitle),
   const OnBoardingEntity(imagePath: AppImages.onboarding2, title:AppText.onboard2 , subtitle: AppText.onboardsubtitle),
   const OnBoardingEntity(imagePath: AppImages.onboarding3,title:AppText.onboard3,subtitle: AppText.onboardsubtitle),
  ];

  @override
  List<Object?> get props => [imagePath,title,subtitle];

}