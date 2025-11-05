import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/privacy_policy/local_data_source/privacy_policy_local_data_source_impl.dart';
import 'package:fitness_app/api/models/account/privacy_and_security/privacy_policy_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAssetBundle = MockAssetBundle();
  final privacyPolicyLocalDataSourceImpl = PrivacyPolicyLocalDataSourceImpl(
    mockAssetBundle,
  );
  test(
    'when call fetchPrivacyPolicyData it should be called successfully return PrivacyPolicyEntity',
    () async {
      // Arrange
      const mockJson = '''
    {
  "privacy_policy": [
    {
      "section": "title",
      "content": {
        "en": "Privacy Policy",
        "ar": "سياسة الخصوصية"
      },
      "style": {
        "fontSize": 24,
        "fontWeight": "bold",
        "color": "#ffffff",
        "textAlign": {
          "en": "center",
          "ar": "center"
        },
        "backgroundColor": "#FFFFFF"
      }
    }]}
    ''';
      final jsonData = json.decode(mockJson) as Map<String, dynamic>;
      final privacyPolicyData = PrivacyPolicyModel.fromJson(jsonData);
      final expectedPrivacyPolicyEntity = privacyPolicyData.toEntity();
      final expectedPrivacyPolicyResult = Success(expectedPrivacyPolicyEntity);
      provideDummy<Result<PrivacyPolicyEntity>>(expectedPrivacyPolicyResult);
      when(
        mockAssetBundle.loadString(AppJson.privacyAndSecurity),
      ).thenAnswer((_) async => mockJson);

      // Act
      final result = await privacyPolicyLocalDataSourceImpl
          .fetchPrivacyPolicyData();

      // Assert
      expect(result, isA<Success<PrivacyPolicyEntity>>());
      final successResult = result as Success<PrivacyPolicyEntity>;
      verify(mockAssetBundle.loadString(AppJson.privacyAndSecurity)).called(1);
      expect(successResult.data, equals(expectedPrivacyPolicyResult.data));
      expect(
        successResult.data.sections,
        equals(expectedPrivacyPolicyResult.data.sections),
      );
      expect(
        successResult.data.sections.elementAt(0),
        equals(expectedPrivacyPolicyResult.data.sections.elementAt(0)),
      );
    },
  );
}
