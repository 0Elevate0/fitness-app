import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/text_style_entity.dart';
import 'package:fitness_app/domain/use_cases/privacy_policy/privacy_policy_use_case.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_cubit.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_intent.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'privacy_policy_cubit_test.mocks.dart';

@GenerateMocks([PrivacyPolicyUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPrivacyPolicyUseCase mockPrivacyPolicyUseCase;
  late PrivacyPolicyCubit cubit;
  late Result<PrivacyPolicyEntity> expectedSuccessResult;
  late Failure<PrivacyPolicyEntity> expectedFailureResult;
  late PrivacyPolicyEntity expectedPrivacyPolicyData;

  setUpAll(() {
    mockPrivacyPolicyUseCase = MockPrivacyPolicyUseCase();
  });
  setUp(() {
    cubit = PrivacyPolicyCubit(mockPrivacyPolicyUseCase);
  });

  group("PrivacyPolicy cubit test", () {
    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      'emits [Loading, Success] when FetchPrivacyPolicyDataIntent succeeds',
      build: () {
        expectedPrivacyPolicyData = const PrivacyPolicyEntity(
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
        expectedSuccessResult = Success<PrivacyPolicyEntity>(
          expectedPrivacyPolicyData,
        );
        provideDummy<Result<PrivacyPolicyEntity>>(expectedSuccessResult);
        when(
          mockPrivacyPolicyUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchPrivacyPolicyDataIntent()),
      expect: () => [
        isA<PrivacyPolicyState>().having(
          (state) => state.privacyPolicyStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<PrivacyPolicyState>()
            .having(
              (state) => state.privacyPolicyStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.privacyPolicyStatus.data,
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<PrivacyPolicyEntity>).data,
              ),
            )
            .having(
              (state) => state.privacyPolicyStatus.data?.sections,
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<PrivacyPolicyEntity>)
                    .data
                    .sections,
              ),
            )
            .having(
              (state) => state.privacyPolicyStatus.data?.sections.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<PrivacyPolicyEntity>)
                    .data
                    .sections
                    .elementAt(0),
              ),
            )
            .having(
              (state) => state.privacyPolicyStatus.data?.sections.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<PrivacyPolicyEntity>)
                    .data
                    .sections
                    .elementAt(1),
              ),
            ),
      ],
      verify: (_) {
        verify(mockPrivacyPolicyUseCase.invoke()).called(1);
      },
    );

    blocTest<PrivacyPolicyCubit, PrivacyPolicyState>(
      "emits [Loading, Failure] when FetchPrivacyPolicyDataIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to load privacy data",
          ),
        );

        provideDummy<Result<PrivacyPolicyEntity>>(expectedFailureResult);
        when(
          mockPrivacyPolicyUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchPrivacyPolicyDataIntent()),
      expect: () => [
        isA<PrivacyPolicyState>().having(
          (state) => state.privacyPolicyStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<PrivacyPolicyState>()
            .having(
              (state) => state.privacyPolicyStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.privacyPolicyStatus.error?.message,
              'responseException.message',
              equals(expectedFailureResult.responseException.message),
            ),
      ],
      verify: (_) {
        verify(mockPrivacyPolicyUseCase.invoke()).called(1);
      },
    );
  });
}
