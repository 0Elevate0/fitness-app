import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/repositories/privacy_policy/privacy_policy_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PrivacyPolicyUseCase {
  final PrivacyPolicyRepository _privacyPolicyRepository;
  const PrivacyPolicyUseCase(this._privacyPolicyRepository);

  Future<Result<PrivacyPolicyEntity>> invoke() async {
    return await _privacyPolicyRepository.fetchPrivacyPolicyData();
  }
}
