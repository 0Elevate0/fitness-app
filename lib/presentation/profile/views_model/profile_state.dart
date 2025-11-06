import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';

final class ProfileState extends Equatable {
  final StateStatus<void> logoutStatus;
  const ProfileState({this.logoutStatus = const StateStatus.initial()});

  ProfileState copyWith({StateStatus<void>? logoutStatus}) {
    return ProfileState(logoutStatus: logoutStatus ?? this.logoutStatus);
  }

  @override
  List<Object?> get props => [logoutStatus];
}
