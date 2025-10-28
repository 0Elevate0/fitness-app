import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/domain/repositories/recommendation_random_muscles/recommendation_random_muscles_repository.dart';
import 'package:fitness_app/domain/use_cases/recommendation_random_muscles/get_recommendation_random_muscles_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_recommendation_random_muscles_use_case_test.mocks.dart';

@GenerateMocks([RecommendationRandomMusclesRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getRecommendationRandomMuscles it should be called successfully from RecommendationRandomMusclesRepository and returns a List of MuscleEntity',
    () async {
      // Arrange
      final MockRecommendationRandomMusclesRepository
      mockedRecommendationRandomMusclesRepository =
          MockRecommendationRandomMusclesRepository();
      final getRecommendationRandomMusclesUseCase =
          GetRecommendationRandomMusclesUseCase(
            mockedRecommendationRandomMusclesRepository,
          );
      final expectedMuscleEntityList = const [
        MuscleEntity(image: "shoulder image", name: "shoulder", id: "1"),
        MuscleEntity(image: "triceps image", name: "triceps", id: "2"),
      ];
      final expectedResult = Success<List<MuscleEntity>>(
        expectedMuscleEntityList,
      );
      provideDummy<Result<List<MuscleEntity>>>(expectedResult);
      when(
        mockedRecommendationRandomMusclesRepository
            .getRecommendationRandomMuscles(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getRecommendationRandomMusclesUseCase.invoke();

      // Assert
      expect(result, isA<Success<List<MuscleEntity>>>());
      final successResult = result as Success<List<MuscleEntity>>;
      expect(successResult.data, equals(expectedMuscleEntityList));
      expect(
        successResult.data.elementAt(0),
        equals(expectedMuscleEntityList.elementAt(0)),
      );
      expect(
        successResult.data.elementAt(1),
        equals(expectedMuscleEntityList.elementAt(1)),
      );
      verify(
        mockedRecommendationRandomMusclesRepository
            .getRecommendationRandomMuscles(),
      ).called(1);
    },
  );
}
