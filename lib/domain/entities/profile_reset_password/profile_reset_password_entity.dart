import 'package:equatable/equatable.dart';

class ProfileResetPasswordRequestEntity extends Equatable {
  final String password;
  final String newPassword;

  const ProfileResetPasswordRequestEntity({
    required this.password,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [password, newPassword];
}
