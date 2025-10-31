import 'package:equatable/equatable.dart';

final class OnboardingEntity extends Equatable {
  const OnboardingEntity({
    required this.title,
    required this.subTitle,
    required this.onboardingImage,
  });

  final String title;
  final String subTitle;
  final String onboardingImage;
  @override
  List<Object?> get props => [title, subTitle, onboardingImage];
}
