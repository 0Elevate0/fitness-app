import 'package:fitness_app/api/models/difficulty_levels/difficulty_levels_model.dart';
import 'package:fitness_app/api/responses/difficulty_levels_response/difficulty_levels_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/domain/repositories/difficult_levels_by_prime_mover/difficult_levels_repository.dart';
import 'package:fitness_app/domain/use_cases/difficult_levels_by_prime_mover/difficult_levels_use_case.dart';

import 'difficult_levels_use_case_test.mocks.dart';

@GenerateMocks([DifficultLevelsRepository])
void main() {
  test('Implement tests for difficult_levels_use_case.dart', () async {
    final mockRepository = MockDifficultLevelsRepository();
    final useCase = DifficultLevelsUseCase(mockRepository);

    final expectedDifficultyLevelsModelList = [
      DifficultyLevelsModel(id: "1", name: "Beginner"),
      DifficultyLevelsModel(id: "2", name: "Intermediate"),
    ];
    final expectedResponse = DifficultyLevelsResponse(
      message: "success",
      difficultyLevels: expectedDifficultyLevelsModelList,
    );
    final expectedDifficultyLevelEntityList =
        expectedResponse.difficultyLevels
            ?.map((difficulty) => difficulty.toDifficultyLevelEntity())
            .toList() ??
        [];
    final expectedResult = Success<List<DifficultyLevelEntity>>(
      expectedDifficultyLevelEntityList,
    );
    provideDummy<Result<List<DifficultyLevelEntity>>>(expectedResult);

    when(
      mockRepository.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: "primeMoverMuscleId",
      ),
    ).thenAnswer((_) async => expectedResult);

    final result = await useCase.call(primeMoverMuscleId: "primeMoverMuscleId");

    expect(result, isA<Success<List<DifficultyLevelEntity>>>());
    final successResult = result as Success<List<DifficultyLevelEntity>>;
    expect(successResult.data, equals(expectedDifficultyLevelEntityList));

    verify(
      mockRepository.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: "primeMoverMuscleId",
      ),
    ).called(1);
  });
}
