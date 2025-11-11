class ResetPasswordRequestEntity {
  final String? email;
  final String? newPassword;

  const ResetPasswordRequestEntity({
    this.email,
    this.newPassword,
  });
}
