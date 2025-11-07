import 'package:fitness_app/api/models/difficulty_levels/difficulty_levels_model.dart';
import 'package:fitness_app/api/responses/difficulty_levels_response/difficulty_levels_response.dart';
import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/difficulty_level/difficulty_level_entity.dart';
import 'package:fitness_app/data/data_source/difficult_levels_by_prime_mover/remote_data_source/difficult_levels_remote_data_source.dart';
import 'package:fitness_app/data/repositories/difficult_levels_by_prime_mover/difficult_levels_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'difficult_levels_repository_impl_test.mocks.dart';

@GenerateMocks([DifficultLevelRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Implement tests for difficult_levels_repository_impl.dart', () async {
    final mockRemoteDataSource = MockDifficultLevelRemoteDataSource();
    final repository = DifficultLevelsRepositoryImpl(mockRemoteDataSource);

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
      mockRemoteDataSource.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: 'primeMoverMuscleId',
      ),
    ).thenAnswer((_) async => expectedResult);

    final result = await repository.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId: 'primeMoverMuscleId',
    );

    expect(result, isA<Success<List<DifficultyLevelEntity>>>());
    final successResult = result as Success<List<DifficultyLevelEntity>>;
    expect(successResult.data, equals(expectedDifficultyLevelEntityList));

    verify(
      mockRemoteDataSource.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: 'primeMoverMuscleId',
      ),
    ).called(1);
  });
}
