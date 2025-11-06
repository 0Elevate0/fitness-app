import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/logout/logout_use_case.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_intent.dart';
import 'package:fitness_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final LogoutUseCase _logoutUseCase;
  ProfileCubit(this._logoutUseCase) : super(const ProfileState());

  Future<void> doIntent({required ProfileIntent intent}) async {
    switch (intent) {
      case LogoutIntent():
        await _logout();
        break;
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutStatus: const StateStatus.loading()));
    final result = await _logoutUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<void>():
        emit(state.copyWith(logoutStatus: const StateStatus.success(null)));
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            logoutStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(logoutStatus: const StateStatus.initial()));
        break;
    }
  }
}
