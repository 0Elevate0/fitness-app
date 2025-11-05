import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/models/account/help/help_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/data/data_source/help/local_data_source/help_local_data_source.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HelpLocalDataSource)
final class HelpLocalDataSourceImpl implements HelpLocalDataSource {
  final AssetBundle _assetBundle;
  const HelpLocalDataSourceImpl(this._assetBundle);
  @override
  Future<Result<HelpEntity>> fetchHelpData() async {
    try {
      final String jsonString = await _assetBundle.loadString(AppJson.help);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final result = HelpModel.fromJson(jsonData);
      return Success(result.toEntity());
    } catch (error) {
      return Failure(
        responseException: ResponseException(message: error.toString()),
      );
    }
  }
}
