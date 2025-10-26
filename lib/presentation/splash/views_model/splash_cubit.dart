import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/core/secure_storage/secure_storage.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_intent.dart';
import 'package:fitness_app/presentation/splash/views_model/splash_state.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final SecureStorage _secureStorage;
  SplashCubit(this._getUserDataUseCase, this._secureStorage)
    : super(const SplashState());

  Future<void> doIntent({required SplashIntent intent}) async {
    switch (intent) {
      case GetUserDataIntent():
        await _getUserData();
        break;
      case NavigateToLoginViewIntent():
        await _navigateToLogin();
        break;
    }
  }

  Future<void> _getUserData() async {
    emit(state.copyWith(userDataStatus: const StateStatus.loading()));
    final result = await _getUserDataUseCase.invoke();
    switch (result) {
      case Success<void>():
        emit(state.copyWith(userDataStatus: const StateStatus.success(null)));
        break;
      case Failure<void>():
        emit(
          state.copyWith(
            userDataStatus: StateStatus.failure(result.responseException),
          ),
        );
        emit(state.copyWith(userDataStatus: const StateStatus.initial()));
        break;
    }
  }

  Future<void> _navigateToLogin() async {
    await _secureStorage.deleteData(key: ConstKeys.tokenKey);
    FitnessMethodHelper.currentUserToken = null;
    FitnessMethodHelper.userData = null;
    emit(state.copyWith(isNavigationToLogin: true));
  }
}
