import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/onboarding/onboarding_entity.dart';

final class OnboardingState extends Equatable {
  final List<OnboardingEntity> onboardingList = const [
    OnboardingEntity(
      title: AppText.onboardingTitle1,
      subTitle: AppText.onboardingSubTitle1,
      onboardingImage: AppImages.onboarding1,
    ),
    OnboardingEntity(
      title: AppText.onboardingTitle2,
      subTitle: AppText.onboardingSubTitle2,
      onboardingImage: AppImages.onboarding2,
    ),
    OnboardingEntity(
      title: AppText.onboardingTitle3,
      subTitle: AppText.onboardingSubTitle3,
      onboardingImage: AppImages.onboarding3,
    ),
  ];

  final int currentPageIndex;
  final bool isDoIt;

  const OnboardingState({this.currentPageIndex = 0, this.isDoIt = false});

  OnboardingState copyWith({int? currentPageIndex, bool? isDoIt}) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isDoIt: isDoIt ?? this.isDoIt,
    );
  }

  @override
  List<Object?> get props => [currentPageIndex, isDoIt];
}
