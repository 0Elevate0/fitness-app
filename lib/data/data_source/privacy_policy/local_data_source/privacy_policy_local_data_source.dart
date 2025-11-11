import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';

abstract interface class PrivacyPolicyLocalDataSource {
  Future<Result<PrivacyPolicyEntity>> fetchPrivacyPolicyData();
}
