import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/models/account/security_roles_config/security_roles_config_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/data/data_source/security_roles_config/local_data_source/security_roles_config_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SecurityRolesConfigLocalDataSource)
final class SecurityRolesConfigLocalDataSourceImpl
    implements SecurityRolesConfigLocalDataSource {
  final AssetBundle _assetBundle;
  const SecurityRolesConfigLocalDataSourceImpl(this._assetBundle);
  @override
  Future<Result<SecurityRolesConfigEntity>>
  fetchSecurityRolesConfigData() async {
    try {
      final String jsonString = await _assetBundle.loadString(
        AppJson.securityRolesConfig,
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final result = SecurityRolesConfigModel.fromJson(jsonData);
      return Success(result.toEntity());
    } catch (error) {
      return Failure(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }
}
