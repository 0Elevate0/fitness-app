sealed class HomeIntent {
  const HomeIntent();
}

final class HomeInitializationIntent extends HomeIntent {
  const HomeInitializationIntent();
}

final class ChangeMusclesGroupIntent extends HomeIntent {
  final String muscleGroupId;
  const ChangeMusclesGroupIntent({required this.muscleGroupId});
}
