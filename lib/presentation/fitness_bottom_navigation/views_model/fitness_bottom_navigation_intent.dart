sealed class FitnessBottomNavigationIntent {
  const FitnessBottomNavigationIntent();
}

final class ChangeIndexIntent extends FitnessBottomNavigationIntent {
  final int index;
  const ChangeIndexIntent({required this.index});
}
