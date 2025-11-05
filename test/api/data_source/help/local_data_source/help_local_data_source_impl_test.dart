import 'dart:convert';

import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/api/data_source/help/local_data_source/help_local_data_source_impl.dart';
import 'package:fitness_app/api/models/account/help/help_model.dart';
import 'package:fitness_app/core/constants/app_json.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_local_data_source_impl_test.mocks.dart';

@GenerateMocks([AssetBundle])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAssetBundle = MockAssetBundle();
  final helpLocalDataSourceImpl = HelpLocalDataSourceImpl(mockAssetBundle);
  test(
    'when call fetchHelpData it should be called successfully return HelpEntity',
    () async {
      // Arrange
      const mockJson = '''
    {
      "help_screen_content": [
          {
          "section": "page_title",
          "content": {
          "en": "Help & Support",
          "ar": "المساعدة والدعم"
          },
          "style": {
          "fontSize": 24,
          "fontWeight": "bold",
          "color": "#FFFFFF",
          "textAlign": {
          "en": "center",
          "ar": "center"
          },
          "backgroundColor": "#121212"
          }
          }]}
    ''';
      final jsonData = json.decode(mockJson) as Map<String, dynamic>;
      final HelpModel helpData = HelpModel.fromJson(jsonData);
      final expectedHelpEntity = helpData.toEntity();
      final expectedHelpResult = Success(expectedHelpEntity);
      provideDummy<Result<HelpEntity>>(expectedHelpResult);
      when(
        mockAssetBundle.loadString(AppJson.help),
      ).thenAnswer((_) async => mockJson);

      // Act
      final result = await helpLocalDataSourceImpl.fetchHelpData();

      // Assert
      expect(result, isA<Success<HelpEntity>>());
      final successResult = result as Success<HelpEntity>;
      verify(mockAssetBundle.loadString(AppJson.help)).called(1);
      expect(successResult.data, equals(expectedHelpResult.data));
      expect(
        successResult.data.helpScreenContent,
        equals(expectedHelpResult.data.helpScreenContent),
      );
      expect(
        successResult.data.helpScreenContent?.elementAt(0),
        equals(expectedHelpResult.data.helpScreenContent?.elementAt(0)),
      );
    },
  );
}
