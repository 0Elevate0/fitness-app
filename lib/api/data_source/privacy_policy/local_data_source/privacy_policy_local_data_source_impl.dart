import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_policy_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/data/data_source/privacy_policy/local_data_source/privacy_policy_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PrivacyPolicyLocalDataSource)
final class PrivacyPolicyLocalDataSourceImpl
    implements PrivacyPolicyLocalDataSource {
  final AssetBundle _assetBundle;
  const PrivacyPolicyLocalDataSourceImpl(this._assetBundle);
  @override
  Future<Result<PrivacyPolicyEntity>> fetchPrivacyPolicyData() async {
    try {
      final String jsonString = await _assetBundle.loadString(
        AppJson.privacyAndSecurity,
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final result = PrivacyPolicyModel.fromJson(jsonData);
      return Success(result.toEntity());
    } catch (error) {
      return Failure(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }
}
