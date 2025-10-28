import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/data/data_source/recommendation_random_muscles/remote_data_source/recommendation_random_muscles_remote_data_source.dart';
import 'package:fitness_app/data/repositories/recommendation_random_muscles/recommendation_random_muscles_repository_impl.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_random_muscles_repository_impl_test.mocks.dart';

@GenerateMocks([RecommendationRandomMusclesRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getRecommendationTodayMuscles it should be called successfully from RecommendationRandomMusclesRemoteDataSource and returns a List of MuscleEntity',
    () async {
      // Arrange
      final MockRecommendationRandomMusclesRemoteDataSource
      mockedRecommendationRandomMusclesRemoteDataSource =
          MockRecommendationRandomMusclesRemoteDataSource();
      final recommendationRandomMusclesRepositoryImpl =
          RecommendationRandomMusclesRepositoryImpl(
            mockedRecommendationRandomMusclesRemoteDataSource,
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
        mockedRecommendationRandomMusclesRemoteDataSource
            .getRecommendationRandomMuscles(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await recommendationRandomMusclesRepositoryImpl
          .getRecommendationRandomMuscles();

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
        mockedRecommendationRandomMusclesRemoteDataSource
            .getRecommendationRandomMuscles(),
      ).called(1);
    },
  );
}
