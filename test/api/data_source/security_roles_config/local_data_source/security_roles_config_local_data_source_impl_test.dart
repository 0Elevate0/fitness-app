import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/security_roles_config/local_data_source/security_roles_config_local_data_source_impl.dart';
import 'package:fitness_app/api/models/account/security_roles_config/security_roles_config_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'security_roles_config_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAssetBundle = MockAssetBundle();
  final securityRolesConfigLocalDataSourceImpl =
      SecurityRolesConfigLocalDataSourceImpl(mockAssetBundle);
  test(
    'when call fetchSecurityRolesConfigData it should be called successfully return SecurityRolesConfigEntity',
    () async {
      // Arrange
      const mockJson = '''
    {
  "security_roles_config": [
    {
      "section": "page_title",
      "content": {
        "en": "User Roles & Permissions",
        "ar": "أدوار وصلاحيات المستخدمين"
      },
      "style": {
        "fontSize": 24,
        "fontWeight": "bold",
        "color": "#ffffff",
        "textAlign": {
          "en": "left",
          "ar": "right"
        },
        "backgroundColor": "#FFFFFF"
      }
    }]}
    ''';
      final jsonData = json.decode(mockJson) as Map<String, dynamic>;
      final securityData = SecurityRolesConfigModel.fromJson(jsonData);
      final expectedSecurityEntity = securityData.toEntity();
      final expectedSecurityResult = Success(expectedSecurityEntity);
      provideDummy<Result<SecurityRolesConfigEntity>>(expectedSecurityResult);
      when(
        mockAssetBundle.loadString(AppJson.securityRolesConfig),
      ).thenAnswer((_) async => mockJson);

      // Act
      final result = await securityRolesConfigLocalDataSourceImpl
          .fetchSecurityRolesConfigData();

      // Assert
      expect(result, isA<Success<SecurityRolesConfigEntity>>());
      final successResult = result as Success<SecurityRolesConfigEntity>;
      verify(mockAssetBundle.loadString(AppJson.securityRolesConfig)).called(1);
      expect(successResult.data, equals(expectedSecurityResult.data));
      expect(
        successResult.data.sections,
        equals(expectedSecurityResult.data.sections),
      );
      expect(
        successResult.data.sections?.elementAt(0),
        equals(expectedSecurityResult.data.sections?.elementAt(0)),
      );
    },
  );
}
