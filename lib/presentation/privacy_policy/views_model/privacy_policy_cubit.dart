import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/use_cases/privacy_policy/privacy_policy_use_case.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_intent.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final PrivacyPolicyUseCase _privacyPolicyUseCase;
  PrivacyPolicyCubit(this._privacyPolicyUseCase)
    : super(const PrivacyPolicyState());

  Future<void> doIntent({required PrivacyPolicyIntent intent}) async {
    switch (intent) {
      case FetchPrivacyPolicyDataIntent():
        await _fetchPrivacyPolicyData();
        break;
    }
  }

  Future<void> _fetchPrivacyPolicyData() async {
    emit(state.copyWith(privacyPolicyStatus: const StateStatus.loading()));
    final result = await _privacyPolicyUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<PrivacyPolicyEntity>():
        emit(
          state.copyWith(privacyPolicyStatus: StateStatus.success(result.data)),
        );
        break;
      case Failure<PrivacyPolicyEntity>():
        emit(
          state.copyWith(
            privacyPolicyStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }
}
