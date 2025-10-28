import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';

final class SplashState extends Equatable {
  final StateStatus<void> userDataStatus;
  final bool isNavigationToLogin;
  const SplashState({
    this.userDataStatus = const StateStatus.initial(),
    this.isNavigationToLogin = false,
  });
  SplashState copyWith({
    StateStatus<void>? userDataStatus,
    bool? isNavigationToLogin,
  }) {
    return SplashState(
      userDataStatus: userDataStatus ?? this.userDataStatus,
      isNavigationToLogin: isNavigationToLogin ?? this.isNavigationToLogin,
    );
  }

  @override
  List<Object?> get props => [userDataStatus, isNavigationToLogin];
}
