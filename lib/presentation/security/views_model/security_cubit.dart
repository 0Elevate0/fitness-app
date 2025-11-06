import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/use_cases/security_roles_config/security_roles_config_use_case.dart';
import 'package:fitness_app/presentation/security/views_model/security_intent.dart';
import 'package:fitness_app/presentation/security/views_model/security_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecurityCubit extends Cubit<SecurityState> {
  final SecurityRolesConfigUseCase _securityRolesConfigUseCase;
  SecurityCubit(this._securityRolesConfigUseCase)
    : super(const SecurityState());

  Future<void> doIntent({required SecurityIntent intent}) async {
    switch (intent) {
      case FetchSecurityDataIntent():
        await _fetchSecurityData();
        break;
    }
  }

  Future<void> _fetchSecurityData() async {
    emit(state.copyWith(securityStatus: const StateStatus.loading()));
    final result = await _securityRolesConfigUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<SecurityRolesConfigEntity>():
        emit(state.copyWith(securityStatus: StateStatus.success(result.data)));
        break;
      case Failure<SecurityRolesConfigEntity>():
        emit(
          state.copyWith(
            securityStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }
}
