final class EditProfileRequestEntity {
  final String? firstName;
  final String? lastName;
  final int? weight;
  final String? goal;
  final String? activityLevel;

  const EditProfileRequestEntity({
    this.firstName,
    this.lastName,
    this.weight,
    this.goal,
    this.activityLevel,
  });
}
