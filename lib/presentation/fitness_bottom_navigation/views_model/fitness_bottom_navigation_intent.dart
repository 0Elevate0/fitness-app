abstract class HomeNavIntent {}

class FitnessBottomNavigationIntent extends HomeNavIntent {
  final int newIndex;

  FitnessBottomNavigationIntent(this.newIndex);
}
