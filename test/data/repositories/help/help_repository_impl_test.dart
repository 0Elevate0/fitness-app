import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/help/local_data_source/help_local_data_source.dart';
import 'package:fitness_app/data/repositories/help/help_repository_impl.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_repository_impl_test.mocks.dart';

@GenerateMocks([HelpLocalDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call fetchHelpData it should be called successfully from HelpLocalDataSource and return HelpEntity',
    () async {
      // Arrange
      final mockedHelpLocalDataSource = MockHelpLocalDataSource();

      final expectedHelpData = const HelpEntity(
        helpScreenContent: [
          HelpSectionEntity(
            section: "page_title",
            content: ContentEntity(en: "Help & Support", ar: "المساعدة والدعم"),
            style: StyleEntity(
              fontSize: 24,
              fontWeight: "bold",
              color: "#FFFFFF",
              backgroundColor: "#121212",
              textAlign: LocalizedTextAlignEntity(en: "center", ar: "center"),
            ),
          ),
          HelpSectionEntity(
            section: "page_subtitle",
            content: ContentEntity(
              en: "How can we help you today?",
              ar: "كيف يمكننا مساعدتك اليوم؟",
            ),
            style: StyleEntity(
              fontSize: 16,
              fontWeight: "normal",
              color: "#CCCCCC",
              backgroundColor: "#121212",
              textAlign: LocalizedTextAlignEntity(en: "center", ar: "center"),
            ),
          ),
        ],
      );

      final helpRepositoryImpl = HelpRepositoryImpl(mockedHelpLocalDataSource);
      final expectedHelpEntityResult = Success<HelpEntity>(expectedHelpData);
      provideDummy<Result<HelpEntity>>(expectedHelpEntityResult);
      when(
        mockedHelpLocalDataSource.fetchHelpData(),
      ).thenAnswer((_) async => expectedHelpEntityResult);

      // Act
      final result = await helpRepositoryImpl.fetchHelpData();

      // Assert
      verify(mockedHelpLocalDataSource.fetchHelpData()).called(1);
      expect(result, isA<Success<HelpEntity>>());
      final successResult = result as Success<HelpEntity>;
      expect(successResult.data, equals(expectedHelpEntityResult.data));
      expect(
        successResult.data.helpScreenContent,
        equals(expectedHelpEntityResult.data.helpScreenContent),
      );
      expect(
        successResult.data.helpScreenContent?.elementAt(0),
        equals(expectedHelpEntityResult.data.helpScreenContent?.elementAt(0)),
      );
    },
  );
}
