import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/user_data_entity/user_data_entity.dart';

final class ProfileState extends Equatable {
  final StateStatus<void> logoutStatus;
  final UserDataEntity? userData;
  const ProfileState({
    this.logoutStatus = const StateStatus.initial(),
    this.userData,
  });

  ProfileState copyWith({
    StateStatus<void>? logoutStatus,
    UserDataEntity? userData,
  }) {
    return ProfileState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [logoutStatus, userData];
}
