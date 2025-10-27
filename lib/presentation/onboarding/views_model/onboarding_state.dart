import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';

final class OnboardingState extends Equatable {
  final int currentpageindex;
  final bool isdoit;
  static final List<OnBoardingEntity>onbourding=[
    const OnBoardingEntity(imagePath:  AppImages.onboarding1, title:AppText.onboardingTitle1 , subtitle:AppText.onboardingSubTitle1),
    const OnBoardingEntity(imagePath: AppImages.onboarding2, title:AppText.onboardingTitle2 , subtitle: AppText.onboardingSubTitle2),
    const OnBoardingEntity(imagePath: AppImages.onboarding3,title:AppText.onboardingTitle3,subtitle: AppText.onboardingSubTitle3),
  ];

  const OnboardingState( {this.currentpageindex=0,  this.isdoit=false});
OnboardingState copyWith({int? currentpageindex,bool ?isdoit}){
  return OnboardingState(currentpageindex: currentpageindex??this.currentpageindex, isdoit: isdoit??this.isdoit);
}
  @override
  List<Object?> get props =>[currentpageindex,isdoit];
}
