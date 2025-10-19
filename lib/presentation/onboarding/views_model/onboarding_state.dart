import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  final int currentPageIndex;

  const OnboardingState({this.currentPageIndex = 0});

  OnboardingState copyWith({int? currentPageIndex}) {
    return OnboardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }

  @override
  List<Object?> get props => [currentPageIndex];
}
