import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/exceptions/response_exception.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/localized_text_align_entity.dart';
import 'package:fitness_app/domain/use_cases/help/help_use_case.dart';
import 'package:fitness_app/presentation/help/views_model/help_cubit.dart';
import 'package:fitness_app/presentation/help/views_model/help_intent.dart';
import 'package:fitness_app/presentation/help/views_model/help_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'help_cubit_test.mocks.dart';

@GenerateMocks([HelpUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockHelpUseCase mockHelpUseCase;
  late HelpCubit cubit;
  late Result<HelpEntity> expectedSuccessResult;
  late Failure<HelpEntity> expectedFailureResult;
  late HelpEntity expectedHelpData;

  setUpAll(() {
    mockHelpUseCase = MockHelpUseCase();
  });
  setUp(() {
    cubit = HelpCubit(mockHelpUseCase);
  });

  group("Help cubit test", () {
    blocTest<HelpCubit, HelpState>(
      'emits [Loading, Success] when FetchHelpDataIntent succeeds',
      build: () {
        expectedHelpData = const HelpEntity(
          helpScreenContent: [
            HelpSectionEntity(
              section: "page_title",
              content: ContentEntity(
                en: "Help & Support",
                ar: "المساعدة والدعم",
              ),
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
        expectedSuccessResult = Success<HelpEntity>(expectedHelpData);
        provideDummy<Result<HelpEntity>>(expectedSuccessResult);
        when(
          mockHelpUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchHelpDataIntent()),
      expect: () => [
        isA<HelpState>().having(
          (state) => state.helpStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HelpState>()
            .having(
              (state) => state.helpStatus.isSuccess,
              "Is in Success state",
              equals(true),
            )
            .having(
              (state) => state.helpStatus.data,
              "Is having the expected data",
              equals((expectedSuccessResult as Success<HelpEntity>).data),
            )
            .having(
              (state) => state.helpStatus.data?.helpScreenContent,
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<HelpEntity>)
                    .data
                    .helpScreenContent,
              ),
            )
            .having(
              (state) => state.helpStatus.data?.helpScreenContent?.elementAt(0),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<HelpEntity>)
                    .data
                    .helpScreenContent
                    ?.elementAt(0),
              ),
            )
            .having(
              (state) => state.helpStatus.data?.helpScreenContent?.elementAt(1),
              "Is having the expected data",
              equals(
                (expectedSuccessResult as Success<HelpEntity>)
                    .data
                    .helpScreenContent
                    ?.elementAt(1),
              ),
            ),
      ],
      verify: (_) {
        verify(mockHelpUseCase.invoke()).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when FetchHelpDataIntent is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to load help data",
          ),
        );

        provideDummy<Result<HelpEntity>>(expectedFailureResult);
        when(
          mockHelpUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const FetchHelpDataIntent()),
      expect: () => [
        isA<HelpState>().having(
          (state) => state.helpStatus.isLoading,
          "Is in loading state",
          equals(true),
        ),
        isA<HelpState>()
            .having(
              (state) => state.helpStatus.isFailure,
              "Is in Failure state",
              equals(true),
            )
            .having(
              (state) => state.helpStatus.error?.message,
              'responseException.message',
              equals(expectedFailureResult.responseException.message),
            ),
      ],
      verify: (_) {
        verify(mockHelpUseCase.invoke()).called(1);
      },
    );
  });
}
