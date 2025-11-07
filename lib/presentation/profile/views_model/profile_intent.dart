sealed class ProfileIntent {
  const ProfileIntent();
}

final class LogoutIntent extends ProfileIntent {}

final class InitializeUserDataIntent extends ProfileIntent {
  final String? newImagePath;
  final String? newFirstName;
  final String? newLastName;
  final int? newWeight;
  final String? newGoal;
  final String? newActivityLevel;
  const InitializeUserDataIntent({
    this.newImagePath,
    this.newFirstName,
    this.newLastName,
    this.newWeight,
    this.newGoal,
    this.newActivityLevel,
  });
}
