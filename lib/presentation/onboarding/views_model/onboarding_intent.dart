sealed class OnboardingIntent {
  const OnboardingIntent();
}
final class OnboardingInitializationIntent extends OnboardingIntent {
  const OnboardingInitializationIntent();
}
final class OnboardingChangePageIntent extends OnboardingIntent {
  final int newPageIndex;
  const OnboardingChangePageIntent(
      { required this.newPageIndex,}
      );
}
final class OnboardingNavigateToDotIndexPageIntent extends OnboardingIntent {
  final int dotIndex;
  const OnboardingNavigateToDotIndexPageIntent(
      { required this.dotIndex,}
      );

}
final class OnboardingMoveToNextPageIntent extends OnboardingIntent{
  const OnboardingMoveToNextPageIntent();
}

final class OnboardingMoveToPreviousPageIntent extends OnboardingIntent{
  const OnboardingMoveToPreviousPageIntent();
}
final class OnboardingSkipIntent extends OnboardingIntent{
  const OnboardingSkipIntent();
}