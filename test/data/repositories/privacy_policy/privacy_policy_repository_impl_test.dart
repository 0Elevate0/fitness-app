import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/privacy_policy/local_data_source/privacy_policy_local_data_source.dart';
import 'package:fitness_app/data/repositories/privacy_policy/privacy_policy_repository_impl.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_repository_impl_test.mocks.dart';

@GenerateMocks([PrivacyPolicyLocalDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call fetchPrivacyPolicyData it should be called successfully from PrivacyPolicyLocalDataSource and return PrivacyPolicyEntity',
    () async {
      // Arrange
      final mockedPrivacyPolicyLocalDataSource =
          MockPrivacyPolicyLocalDataSource();

      final expectedPrivacyPolicyData = const PrivacyPolicyEntity(
        sections: [
          PrivacySectionEntity(
            section: "introduction",
            title: LocalizedTextEntity(en: "Introduction", ar: "مقدمة"),
            content: LocalizedTextEntity(
              en: "Welcome to Apex Fitness. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your data.",
              ar: "مرحبًا بك في أبيكس فيتنس. خصوصيتك مهمة بالنسبة لنا. توضح سياسة الخصوصية هذه كيفية جمع بياناتك واستخدامها وحمايتها.",
            ),
            style: TextStyleEntity(
              fontSize: 18,
              fontWeight: "bold",
              color: "#FFFFFF",
              backgroundColor: "#121212",
              textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
            ),
          ),
          PrivacySectionEntity(
            section: "data_usage",
            title: LocalizedTextEntity(
              en: "How We Use Your Data",
              ar: "كيفية استخدام بياناتك",
            ),
            content: LocalizedTextEntity(
              en: "We use your data to personalize your workout plans, track your progress, and improve our AI recommendations.",
              ar: "نستخدم بياناتك لتخصيص خطط التمرين الخاصة بك، وتتبع تقدمك، وتحسين توصيات الذكاء الاصطناعي لدينا.",
            ),
            style: TextStyleEntity(
              fontSize: 16,
              fontWeight: "normal",
              color: "#CCCCCC",
              backgroundColor: "#1E1E1E",
              textAlign: LocalizedTextAlignEntity(en: "left", ar: "right"),
            ),
            subSections: [
              PrivacySubSectionEntity(
                type: "data_collection",
                title: LocalizedTextEntity(
                  en: "Data We Collect",
                  ar: "البيانات التي نجمعها",
                ),
                content: LocalizedTextEntity(
                  en: "We collect information such as your age, weight, goals, and activity logs to tailor your experience.",
                  ar: "نجمع معلومات مثل عمرك ووزنك وأهدافك وسجل نشاطك لتخصيص تجربتك.",
                ),
              ),
              PrivacySubSectionEntity(
                type: "data_sharing",
                title: LocalizedTextEntity(
                  en: "Data Sharing",
                  ar: "مشاركة البيانات",
                ),
                content: LocalizedTextEntity(
                  en: "Your data is never sold. It is shared only with trusted partners to provide key app functionalities.",
                  ar: "لن يتم بيع بياناتك أبدًا. تتم مشاركتها فقط مع شركاء موثوقين لتقديم وظائف أساسية في التطبيق.",
                ),
              ),
            ],
          ),
        ],
      );

      final privacyPolicyRepositoryImpl = PrivacyPolicyRepositoryImpl(
        mockedPrivacyPolicyLocalDataSource,
      );
      final expectedPrivacyPolicyEntityResult = Success<PrivacyPolicyEntity>(
        expectedPrivacyPolicyData,
      );
      provideDummy<Result<PrivacyPolicyEntity>>(
        expectedPrivacyPolicyEntityResult,
      );
      when(
        mockedPrivacyPolicyLocalDataSource.fetchPrivacyPolicyData(),
      ).thenAnswer((_) async => expectedPrivacyPolicyEntityResult);

      // Act
      final result = await privacyPolicyRepositoryImpl.fetchPrivacyPolicyData();

      // Assert
      verify(
        mockedPrivacyPolicyLocalDataSource.fetchPrivacyPolicyData(),
      ).called(1);
      expect(result, isA<Success<PrivacyPolicyEntity>>());
      final successResult = result as Success<PrivacyPolicyEntity>;
      expect(
        successResult.data,
        equals(expectedPrivacyPolicyEntityResult.data),
      );
      expect(
        successResult.data.sections,
        equals(expectedPrivacyPolicyEntityResult.data.sections),
      );
      expect(
        successResult.data.sections.elementAt(0),
        equals(expectedPrivacyPolicyEntityResult.data.sections.elementAt(0)),
      );
      expect(
        successResult.data.sections.elementAt(1),
        equals(expectedPrivacyPolicyEntityResult.data.sections.elementAt(1)),
      );
    },
  );
}
