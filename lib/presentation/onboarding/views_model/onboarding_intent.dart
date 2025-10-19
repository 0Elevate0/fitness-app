sealed class OnboardingIntent {
  const OnboardingIntent();
}

final class ChangePageIntent extends OnboardingIntent {
  final int pageIndex;
  const ChangePageIntent({required this.pageIndex});
}
