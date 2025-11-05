import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/privacy_policy/local_data_source/privacy_policy_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/repositories/privacy_policy/privacy_policy_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PrivacyPolicyRepository)
final class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  final PrivacyPolicyLocalDataSource _privacyPolicyLocalDataSource;
  const PrivacyPolicyRepositoryImpl(this._privacyPolicyLocalDataSource);

  @override
  Future<Result<PrivacyPolicyEntity>> fetchPrivacyPolicyData() async {
    return await _privacyPolicyLocalDataSource.fetchPrivacyPolicyData();
  }
}
